// Supabase Edge Function: rewrite-article-longform
//
// Purpose: takes a source URL (or pasted article text) and produces a
// genuinely REWRITTEN, original long-form article - not a summary, and
// not a paraphrase that mirrors the source's sentence structure. This is
// specifically for the admin dashboard's "Full Article" publishing flow,
// which is a different content type from the short "News Brief" (that
// one is handled by the existing summarize-news-article function).
//
// Uses Google's Gemini API - the SAME API key/secret your existing
// fetch-golf-headlines / summarize-news-article functions already use,
// if those are already on Gemini. Deploy with the Supabase CLI from
// your project root:
//   supabase functions deploy rewrite-article-longform
//
// If you haven't already set a Gemini key as a secret for this project,
// do it once:
//   supabase secrets set GEMINI_API_KEY=AIza...
// (Secrets are shared across ALL functions in the same Supabase project -
// if summarize-news-article already has GEMINI_API_KEY set, this
// function automatically has access to that exact same secret, no need
// to set it twice.)
//
// This function expects the SAME two input shapes as
// summarize-news-article, so the admin dashboard's existing "paste a
// URL" / "paste article text" inputs work for both:
//   { "url": "https://..." }  OR  { "articleText": "..." }
const GEMINI_API_KEY = Deno.env.get('GEMINI_API_KEY');
const GEMINI_MODEL = 'gemini-3.5-flash'; // Google's current recommended default as of Sept 2026 - gemini-2.5-flash is being retired (shuts down Oct 16, 2026), which is why this returned a 404. If this model name is ever retired too, check https://ai.google.dev/api for Google's current example curl command and swap the name here - nothing else needs to change.
const CORS_HEADERS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Authorization, Content-Type'
};
Deno.serve(async (req)=>{
  if (req.method === 'OPTIONS') {
    return new Response(null, {
      headers: CORS_HEADERS
    });
  }
  try {
    if (!GEMINI_API_KEY) {
      return jsonResponse({
        error: 'server_misconfigured',
        detail: 'GEMINI_API_KEY secret is not set for this function.'
      }, 500);
    }
    const body = await req.json().catch(()=>({}));
    let sourceText = (body.articleText || '').trim();
    const sourceUrl = (body.url || '').trim();
    if (!sourceText && !sourceUrl) {
      return jsonResponse({
        error: 'bad_request',
        detail: 'Provide either "url" or "articleText".'
      }, 400);
    }
    // If a URL was given instead of pasted text, fetch and extract its
    // readable text. This is a plain, dependency-free extraction - good
    // enough for most news pages, but a genuine paywall or heavy
    // JS-rendered page may come back empty, which is reported honestly
    // below rather than silently producing a bad rewrite.
    if (!sourceText && sourceUrl) {
      let pageHtml;
      try {
        const pageRes = await fetch(sourceUrl, {
          headers: {
            'User-Agent': 'Mozilla/5.0 (compatible; ArticleRewriteBot/1.0)'
          }
        });
        if (!pageRes.ok) {
          return jsonResponse({
            error: 'fetch_failed',
            detail: `Could not fetch the URL (status ${pageRes.status}). It may block bots or require a login.`
          }, 502);
        }
        pageHtml = await pageRes.text();
      } catch (err) {
        return jsonResponse({
          error: 'fetch_failed',
          detail: `Could not reach that URL: ${err.message}`
        }, 502);
      }
      sourceText = extractReadableText(pageHtml);
      if (sourceText.length < 200) {
        return jsonResponse({
          error: 'extraction_failed',
          detail: 'Could not find enough readable article text on that page - it may be behind a paywall, or the page loads its content via JavaScript. Try "Paste article text instead."'
        }, 422);
      }
    }
    // Cap how much source text goes to the model - a full HTML page's
    // extracted text can be huge, and the article body itself is what
    // matters, not every nav link and footer fragment that slipped
    // through extraction.
    const trimmedSource = sourceText.slice(0, 12000);
    const rewritePrompt = `You are a sports journalist writing an ORIGINAL long-form article for "MY SPORTS NETWORK" based on the factual content in the source material below.

Hard requirements:
- Do NOT copy or closely paraphrase any sentence from the source. Read it for the FACTS, then write your own piece from scratch in your own structure, your own sentence order, and your own wording throughout.
- Do not reuse the source's headline. Write your own original headline.
- Target 300-500 words of genuine long-form journalism - context, quotes if present (attributed, kept short and exact), and analysis, not a summary.
- Do not fabricate quotes, statistics, or facts that are not present in the source material.
- Write in an engaged, knowledgeable sports-journalist voice - not a dry recap.

Respond with ONLY a JSON object, no other text, no markdown fences:
{"title": "your original headline", "body": "your rewritten article body, plain text with blank lines between paragraphs"}

SOURCE MATERIAL:
"""
${trimmedSource}
"""`;
    // 503 from Gemini specifically means "Google's servers are
    // temporarily overloaded" - a well-documented, common, TRANSIENT
    // condition, not a sign of anything actually broken. Retrying after
    // a short pause resolves it the large majority of the time, so this
    // does that automatically instead of failing on the first hiccup.
    const requestBody = JSON.stringify({
      contents: [
        {
          parts: [
            {
              text: rewritePrompt
            }
          ]
        }
      ],
      generationConfig: {
        temperature: 0.7,
        // Newer Gemini models "think" before answering by default, and
        // that thinking silently shares the SAME token budget as the
        // actual output - with a low maxOutputTokens, thinking alone
        // can consume the whole budget and cut the real answer off
        // mid-sentence (exactly what was happening before this fix).
        // "low" is plenty for a straightforward rewrite task like this
        // one and leaves the rest of the budget for the real output.
        thinkingConfig: {
          thinkingLevel: 'low'
        },
        maxOutputTokens: 8192,
        responseMimeType: 'application/json'
      }
    });
    let aiRes = null;
    let attemptsMade = 0;
    const MAX_ATTEMPTS = 3;
    for(let attempt = 1; attempt <= MAX_ATTEMPTS; attempt++){
      attemptsMade = attempt;
      aiRes = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': GEMINI_API_KEY
        },
        body: requestBody
      });
      if (aiRes.ok) break;
      if (aiRes.status !== 503 || attempt === MAX_ATTEMPTS) break; // only retry on 503, and only up to the attempt limit
      await new Promise((resolve)=>setTimeout(resolve, attempt * 1000)); // 1s, then 2s before the next try
    }
    if (!aiRes.ok) {
      const errBody = await aiRes.text();
      const retryNote = attemptsMade > 1 ? ` (tried ${attemptsMade} times)` : '';
      return jsonResponse({
        error: 'ai_request_failed',
        detail: `The rewriting model returned an error (status ${aiRes.status})${retryNote}.`,
        raw: errBody.slice(0, 500)
      }, 502);
    }
    const aiData = await aiRes.json();
    const rawText = (aiData.candidates?.[0]?.content?.parts || []).map((p)=>p.text || '').join('').trim();
    if (!rawText) {
      // Gemini can return an empty candidate list if its safety filters
      // blocked the content - surface that honestly instead of a
      // confusing generic parse error.
      const blockReason = aiData.candidates?.[0]?.finishReason || aiData.promptFeedback?.blockReason;
      return jsonResponse({
        error: 'empty_response',
        detail: `The model returned no content${blockReason ? ` (reason: ${blockReason})` : ''}. Try a different source.`
      }, 502);
    }
    let parsed;
    try {
      // responseMimeType: 'application/json' above should make this a
      // clean JSON string already, but strip accidental markdown fences
      // defensively just in case.
      const cleaned = rawText.replace(/^```json\s*|```\s*$/g, '').trim();
      parsed = JSON.parse(cleaned);
    } catch (err) {
      const looksTruncated = !rawText.trim().endsWith('}');
      return jsonResponse({
        error: 'parse_failed',
        detail: looksTruncated ? 'The response was cut off before finishing (likely ran out of output tokens). Try again - if this keeps happening, raise maxOutputTokens further in the function code.' : 'The rewritten article could not be parsed - try again.',
        raw: rawText.slice(0, 500)
      }, 502);
    }
    if (!parsed.title || !parsed.body) {
      return jsonResponse({
        error: 'incomplete_response',
        detail: 'The model did not return both a title and a body.'
      }, 502);
    }
    return jsonResponse({
      title: parsed.title,
      body: parsed.body
    });
  } catch (err) {
    return jsonResponse({
      error: 'unexpected_error',
      detail: err.message
    }, 500);
  }
});
function jsonResponse(obj, status = 200) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: {
      ...CORS_HEADERS,
      'Content-Type': 'application/json'
    }
  });
}
// A plain, dependency-free HTML-to-text extraction: strips script/style
// blocks entirely, strips all remaining tags, collapses whitespace. Not
// as good as a real readability parser, but requires no extra packages
// and handles typical news-article HTML well enough for this purpose.
function extractReadableText(html) {
  let text = html.replace(/<script[\s\S]*?<\/script>/gi, ' ').replace(/<style[\s\S]*?<\/style>/gi, ' ').replace(/<!--[\s\S]*?-->/g, ' ').replace(/<\/(p|div|h[1-6]|li|br)>/gi, '\n').replace(/<[^>]+>/g, ' ').replace(/&nbsp;/g, ' ').replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&#39;/g, "'").replace(/[ \t]+/g, ' ').replace(/\n{3,}/g, '\n\n').trim();
  return text;
} // ------------------------------------------------------------
 // ACCEPTANCE TEST (run once deployed - live network access needed)
 // ------------------------------------------------------------
 // curl -X POST 'https://<your-project>.supabase.co/functions/v1/rewrite-article-longform' \
 //   -H "Authorization: Bearer <anon-or-user-jwt>" \
 //   -H "Content-Type: application/json" \
 //   -d '{"url": "https://golf.com/news/some-real-article"}'
 // Expect: {"title": "...", "body": "..."} with body ~300-500 words that
 // reads nothing like the source's own sentences when compared side by side.
