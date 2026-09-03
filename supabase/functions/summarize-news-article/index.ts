// Supabase Edge Function: summarize-news-article
// Deploy: supabase functions deploy summarize-news-article
//
// Purpose: admin-only tool. Takes either a URL (auto-fetches the article) or
// pasted article text, and asks Gemini to write a short, neutral 60-word
// news brief + headline. Returns a DRAFT for the admin to review/edit -
// never publishes anything itself. That's Option A from the plan: cheap
// (very likely $0 - see below), fast, and a human always sees it before
// it goes live.
//
// Uses Gemini 3.5 Flash-Lite instead of Claude specifically for cost:
// it's Google's cheapest current model AND is covered by their free tier
// (Google AI Studio, no credit card required). At this feature's actual
// volume - an admin occasionally clicking a button - this will very
// likely never leave the free tier at all.
//
// CORS is handled from the start this time (see the delete-account /
// check-entitlement fixes from earlier - this was a real, previously-hit bug).
//
// Request:  POST /summarize-news-article
//           { "url": "https://..." }  OR  { "articleText": "pasted text..." }
// Auth:     Authorization: Bearer <admin's JWT>
//
// Response 200: { "title": "...", "summary": "...", "sourceUrl": "..." }
// Response 400: { "error": "missing_input" | "extraction_too_short", ... }
// Response 401: { "error": "unauthenticated" | "not_admin" }
// Response 502: { "error": "fetch_failed", "detail": "..." }

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  const authHeader = req.headers.get("Authorization") ?? "";
  const jwt = authHeader.replace("Bearer ", "");
  if (!jwt) return json({ error: "unauthenticated" }, 401);

  const supabaseAsUser = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: authHeader } } },
  );
  const { data: userData, error: userErr } = await supabaseAsUser.auth.getUser(jwt);
  if (userErr || !userData?.user) return json({ error: "unauthenticated" }, 401);

  // Only admins can trigger this - shouldn't be reachable by a regular
  // account even by accident.
  const supabaseAdmin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );
  const { data: profile } = await supabaseAdmin.from("users").select("role").eq("user_id", userData.user.id).single();
  if (profile?.role !== "admin") return json({ error: "not_admin" }, 401);

  let body: { url?: string; articleText?: string };
  try {
    body = await req.json();
  } catch {
    return json({ error: "missing_input", detail: "Request body must be JSON." }, 400);
  }

  let articleText = body.articleText?.trim() || "";
  const sourceUrl = body.url?.trim() || null;

  // If a URL was given instead of pasted text, fetch and extract it.
  if (!articleText && sourceUrl) {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 10000); // don't let a slow site eat the whole function budget
      const res = await fetch(sourceUrl, {
        headers: { "User-Agent": "Mozilla/5.0 (compatible; MySportsNetworkBot/1.0)" },
        signal: controller.signal,
      });
      clearTimeout(timeoutId);
      if (!res.ok) return json({ error: "fetch_failed", detail: `Site returned status ${res.status}` }, 502);
      const html = await res.text();
      articleText = extractReadableText(html);
    } catch (err) {
      const detail = err.name === "AbortError" ? "The site took too long to respond (timed out after 10s)." : err.message;
      return json({ error: "fetch_failed", detail }, 502);
    }
  }

  if (!articleText) {
    return json({ error: "missing_input", detail: "Provide either a url or articleText." }, 400);
  }

  // Many news sites are paywalled or render content via JavaScript, which a
  // plain server-side fetch can't execute - if what we got is too thin to be
  // a real article, say so honestly instead of summarizing navigation menus
  // or a paywall notice as if it were the story.
  if (articleText.length < 200) {
    return json({
      error: "extraction_too_short",
      detail: "Could not extract enough article text (the site may block automated access or require JavaScript). Try pasting the article text directly instead.",
    }, 400);
  }

  const truncated = articleText.slice(0, 6000); // keep the call cheap and fast

  const prompt = `Write a short golf news brief from this article, for a news feed card. Respond with ONLY valid JSON, no other text, in this exact shape: {"title": "a short neutral headline, under 10 words", "summary": "a neutral, factual summary in 60 words or fewer"}\n\nArticle text:\n${truncated}`;

  const geminiRes = await fetch(
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash-lite:generateContent",
    {
      method: "POST",
      headers: {
        "x-goog-api-key": Deno.env.get("GEMINI_API_KEY")!,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        contents: [{ parts: [{ text: prompt }] }],
        generationConfig: { maxOutputTokens: 300 },
      }),
    },
  );

  if (!geminiRes.ok) {
    const detail = await geminiRes.text();
    return json({ error: "summarization_failed", detail }, 502);
  }

  const geminiData = await geminiRes.json();
  const rawText = geminiData.candidates?.[0]?.content?.parts?.[0]?.text ?? "";

  // Extract just the {...} block regardless of what's around it - models
  // very commonly wrap JSON in markdown code fences or add a sentence
  // before/after it, even when explicitly told not to. A naive JSON.parse
  // on the raw text would fail on that, which is a real, likely failure
  // mode worth defending against rather than discovering it live.
  let parsed;
  try {
    const match = rawText.match(/\{[\s\S]*\}/);
    if (!match) throw new Error("No JSON object found in the model's response.");
    parsed = JSON.parse(match[0]);
  } catch (err) {
    return json({ error: "summarization_failed", detail: err.message, raw: rawText }, 502);
  }

  return json({ title: parsed.title, summary: parsed.summary, sourceUrl }, 200);
});

// Very small, dependency-free HTML-to-text extractor: pulls text out of
// <p> tags specifically, since that's where the actual article body lives
// on almost every news site's markup, and skips nav/header/footer noise
// that a naive "strip all tags" approach would pull in.
function extractReadableText(html: string): string {
  const paragraphs = [...html.matchAll(/<p[^>]*>(.*?)<\/p>/gis)]
    .map(m => m[1])
    .map(p => p.replace(/<[^>]+>/g, "")) // strip any nested tags
    .map(p => p.replace(/&amp;/g, "&").replace(/&#39;/g, "'").replace(/&quot;/g, '"').replace(/&nbsp;/g, " "))
    .map(p => p.trim())
    .filter(p => p.length > 40); // drop short fragments (captions, nav labels)

  return paragraphs.join("\n\n");
}

function json(body: unknown, status: number) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders },
  });
}

// ------------------------------------------------------------
// ACCEPTANCE TESTS (run once deployed - live network access needed)
// ------------------------------------------------------------
// 1. As a non-admin, call this -> 401 { error: "not_admin" }
// 2. As admin, POST { url: "<a real golf.com article>" } -> 200 with a
//    real title/summary under ~60 words
// 3. As admin, POST { url: "<a heavily paywalled site>" } -> likely
//    400 extraction_too_short - confirms the honest-failure path works
// 4. As admin, POST { articleText: "<a paragraph pasted manually>" } ->
//    200 with a summary, proving the manual-paste fallback works
//    independently of any fetching
// 5. Check your Google AI Studio usage dashboard after a day of normal
//    use - should show $0 charged, confirming free-tier coverage
