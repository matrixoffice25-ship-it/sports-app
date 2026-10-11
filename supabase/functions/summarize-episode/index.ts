// Supabase Edge Function: summarize-episode
// Deploy: supabase functions deploy summarize-episode
// Rebuilt 2026-10-11 by Pink from index.html's podcast/gear episode-summary call
// (function was never committed to the repo — reconstruction).
//
// Purpose: given a YouTube video id, fetch available transcript text, ask Gemini
// to write a short neutral episode summary shown under the Podcast/Gear player.
// Mirrors summarize-news-article's Gemini pattern (cost-cheap Flash Lite model).
//
// Request:  POST { "video_id": "<youtube id>" }      (or { "url": "<watch url>" })
// Auth:     Authorization: Bearer <user JWT>
// Response 200: { "summary": "..." , "cached": true|false }
// Errors:   401 unauthenticated, 400 invalid request / no transcript, 502 gemini failure.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function json(body: unknown, status: number) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders },
  });
}

function extractVideoId(input: string): string | null {
  if (!input) return null;
  if (/^[\w-]{11}$/.test(input)) return input; // bare id
  const m = input.match(/(?:v=|\/shorts\/|youtu\.be\/)([\w-]{11})/);
  return m ? m[1] : (input.match(/([\w-]{11})/) ? input.match(/([\w-]{11})/)![1] : null);
}

async function fetchTranscript(videoId: string): Promise<string | null> {
  try {
    const watch = await fetch(`https://www.youtube.com/watch?v=${videoId}&hl=en`, {
      headers: { "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" },
    });
    if (!watch.ok) return null;
    const html = await watch.text();
    const capMatch = html.match(/"captionTracks":(\[.*?\])/s);
    if (!capMatch) return null;
    const raw = capMatch[1].replace(/\\"/g, '"').replace(/\\u0026/g, "&");
    const tracks = JSON.parse(raw);
    const en = tracks.find((t: { languageCode?: string }) => t.languageCode === "en") || tracks[0];
    if (!en?.baseUrl) return null;
    const tRes = await fetch(en.baseUrl);
    if (!tRes.ok) return null;
    const tXml = await tRes.text();
    const lines = [...tXml.matchAll(/<text[^>]*>([\s\S]*?)<\/text>/g)].map(m =>
      m[1].replace(/&#39;/g, "'").replace(/&quot;/g, '"').replace(/&amp;/g, "&").replace(/<[^>]+>/g, "").replace(/\s+/g, " ").trim()
    );
    const text = lines.join(" ").slice(0, 12000);
    return text.length > 200 ? text : null;
  } catch {
    return null;
  }
}

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return json({ error: "method_not_allowed" }, 405);

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

  let body: { videoId?: string; video_id?: string; url?: string };
  try {
    body = await req.json();
  } catch {
    return json({ error: "invalid_json" }, 400);
  }
  const videoId = extractVideoId(body.videoId || body.video_id || body.url || "");
  if (!videoId) return json({ error: "invalid video_id" }, 400);

  // 1) instant cache lookup (translations_cache doubles as the summary cache)
  const supabaseAdmin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );
  const cacheKey = `episode_summary_${videoId}`;
  const { data: cached } = await supabaseAdmin
    .from("translations_cache").select("value").eq("label_key", cacheKey).maybeSingle();
  if (cached?.value) return json({ summary: cached.value, cached: true }, 200);

  // 2) transcript
  const transcript = await fetchTranscript(videoId);
  if (!transcript) {
    return json({ error: "no_transcript", detail: "No captions/transcript available for this episode. Write the summary manually in the admin panel." }, 400);
  }

  // 3) Gemini summary (same model family as summarize-news-article)
  const geminiKey = Deno.env.get("GEMINI_API_KEY");
  if (!geminiKey) return json({ error: "gemini_not_configured" }, 502);
  try {
    const geminiRes = await fetch(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash-lite:generateContent",
      {
        method: "POST",
        headers: { "Content-Type": "application/json", "x-goog-api-key": geminiKey },
        body: JSON.stringify({
          contents: [{
            parts: [{
              text:
                `You are summarizing a golf coaching episode's transcript for a sports app. ` +
                `Write a tight 3-5 sentence neutral summary of what the episode teaches. ` +
                `Do not editorialize or quote marketing copy.\n\nTRANSCRIPT:\n${transcript}`,
            }],
          }],
          generationConfig: { temperature: 0.3, maxOutputTokens: 400 },
        }),
      },
    );
    if (!geminiRes.ok) {
      return json({ error: "gemini_failed", detail: (await geminiRes.text()).slice(0, 180) }, 502);
    }
    const g = await geminiRes.json();
    const summary: string | undefined = g?.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!summary) return json({ error: "gemini_empty" }, 502);

    // 4) cache for free repeat lookups
    await supabaseAdmin.from("translations_cache").upsert(
      { label_key: cacheKey, value: summary },
      { onConflict: "label_key" },
    );
    return json({ summary, cached: false }, 200);
  } catch (e) {
    return json({ error: "gemini_exception", detail: (e as Error).message }, 502);
  }
});

// ------------------------------------------------------------
// ACCEPTANCE TESTS (run once deployed)
// ------------------------------------------------------------
// 1. No auth -> 401
// 2. Valid video with captions -> 200 { summary } then 200 { cached: true } on repeat
// 3. Video without captions -> 400 no_transcript
// 4. GEMINI_API_KEY missing -> 502 gemini_not_configured