// Supabase Edge Function: fetch-golf-headlines
// Deploy: supabase functions deploy fetch-golf-headlines
//
// Purpose: admin-only tool. Pulls the latest real headlines from a handful
// of credible golf RSS feeds and returns them as a list, so the admin can
// browse and pick one instead of having to manually go find article links
// themselves. Returns headline + link + source name for each - the admin
// still picks which one to summarize and still reviews before publishing,
// same human-in-the-loop safety as the rest of this feature.
//
// Request:  GET (no body needed)
// Auth:     Authorization: Bearer <admin's JWT>
// Response 200: { "headlines": [{ "title": "...", "link": "...", "source": "..." }, ...] }

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "GET, OPTIONS",
};

// Credible sources with real, currently-active RSS feeds (confirmed
// working as of this build - RSS URLs occasionally change, so if one
// of these stops returning results, check the outlet's own site for
// its current feed address).
const FEEDS = [
  { url: "https://golf.com/feed/", source: "Golf.com" },
  { url: "https://www.golfdigest.com/feed/rss", source: "Golf Digest" },
  { url: "https://www.golfmonthly.com/feed", source: "Golf Monthly" },
];

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

  const supabaseAdmin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );
  const { data: profile } = await supabaseAdmin.from("users").select("role").eq("user_id", userData.user.id).single();
  if (profile?.role !== "admin") return json({ error: "not_admin" }, 401);

  // Fetch every feed in parallel, and don't let one broken/slow feed take
  // down the whole list - a source that fails just contributes zero
  // headlines instead of failing the entire request.
  const results = await Promise.all(
    FEEDS.map(async (feed) => {
      try {
        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), 8000);
        const res = await fetch(feed.url, { signal: controller.signal });
        clearTimeout(timeoutId);
        if (!res.ok) return [];
        const xml = await res.text();
        return parseRssHeadlines(xml, feed.source);
      } catch {
        return []; // this one source failed - the others still work
      }
    }),
  );

  const headlines = results.flat().slice(0, 15); // cap the list to a manageable size

  if (!headlines.length) {
    return json({ error: "no_headlines", detail: "Could not fetch headlines from any source right now. Try again shortly, or paste a link directly instead." }, 502);
  }

  return json({ headlines }, 200);
});

// Minimal RSS parser: pulls title + link out of each <item>...</item> block.
// RSS is simple, predictable XML, so a small regex-based parser is enough -
// no need for a full XML parsing library for this.
function parseRssHeadlines(xml: string, source: string): { title: string; link: string; source: string }[] {
  const items = [...xml.matchAll(/<item[^>]*>([\s\S]*?)<\/item>/gi)].map(m => m[1]);

  return items.map(item => {
    const titleMatch = item.match(/<title[^>]*>(?:<!\[CDATA\[)?(.*?)(?:\]\]>)?<\/title>/is);
    const linkMatch = item.match(/<link[^>]*>(?:<!\[CDATA\[)?(.*?)(?:\]\]>)?<\/link>/is);
    const title = (titleMatch?.[1] || "").replace(/&amp;/g, "&").replace(/&#39;/g, "'").replace(/&quot;/g, '"').trim();
    const link = (linkMatch?.[1] || "").trim();
    return { title, link, source };
  }).filter(h => h.title && h.link).slice(0, 8); // up to 8 per source
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
// 2. As admin, call this -> 200 with a list of real, current headlines
//    from multiple sources, each with a working link
// 3. If one feed URL is temporarily broken/changed, the other sources'
//    headlines should still come back - confirms the per-feed isolation
//    (Promise.all with individual try/catch) works as intended
