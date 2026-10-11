// Supabase Edge Function: translate-text
// The app sends a list of short texts + a language; this returns them translated.
// Uses the same GEMINI_API_KEY secret as summarize-episode. Each text is translated once, then remembered.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type"
};
const LANGS = {
  es: "Spanish",
  fr: "French",
  pt: "Portuguese",
  de: "German",
  it: "Italian",
  "zh-Hans": "Simplified Chinese",
  ja: "Japanese",
  ko: "Korean",
  hi: "Hindi",
  ar: "Arabic",
  id: "Indonesian",
  tr: "Turkish",
  ru: "Russian",
  nl: "Dutch",
  pl: "Polish",
  vi: "Vietnamese",
  th: "Thai",
  sv: "Swedish"
};
const MAX_ITEMS = 40, MAX_ITEM_CHARS = 2000, MAX_TOTAL_CHARS = 8000;
async function sha256(text) {
  const buf = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return [
    ...new Uint8Array(buf)
  ].map((b)=>b.toString(16).padStart(2, "0")).join("");
}
Deno.serve(async (req)=>{
  if (req.method === "OPTIONS") return new Response("ok", {
    headers: cors
  });
  const reply = (body)=>new Response(JSON.stringify(body), {
      headers: {
        ...cors,
        "Content-Type": "application/json"
      }
    });
  try {
    const url = Deno.env.get("SUPABASE_URL");
    // 1) Signed-in people only (no anonymous use of the free Gemini allowance)
    const asUser = createClient(url, Deno.env.get("SUPABASE_ANON_KEY"), {
      global: {
        headers: {
          Authorization: req.headers.get("Authorization") ?? ""
        }
      }
    });
    const { data: u } = await asUser.auth.getUser();
    if (!u?.user) return reply({
      error: "Please log in to translate."
    });
    // 2) Check the request
    const { texts, lang } = await req.json().catch(()=>({}));
    if (!LANGS[lang]) return reply({
      error: "That language is not available yet."
    });
    if (!Array.isArray(texts) || !texts.length || texts.length > MAX_ITEMS || texts.some((t)=>typeof t !== "string" || !t.trim() || t.length > MAX_ITEM_CHARS)) {
      return reply({
        error: "Nothing to translate, or too much at once."
      });
    }
    if (texts.reduce((n, t)=>n + t.length, 0) > MAX_TOTAL_CHARS) return reply({
      error: "Too much text at once."
    });
    // 3) Look in memory first
    const db = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY"));
    const unique = [
      ...new Set(texts)
    ];
    const hashOf = new Map();
    for (const t of unique)hashOf.set(t, await sha256(t));
    const known = new Map(); // hash -> translation
    const { data: cached } = await db.from("translations_cache").select("source_hash, translated").eq("lang", lang).in("source_hash", [
      ...hashOf.values()
    ]);
    (cached ?? []).forEach((r)=>known.set(r.source_hash, r.translated));
    // 4) Ask Gemini only for what is new
    const missing = unique.filter((t)=>!known.has(hashOf.get(t)));
    if (missing.length) {
      const key = Deno.env.get("GEMINI_API_KEY");
      if (!key) return reply({
        error: "The Gemini key is not saved in Supabase yet."
      });
      const prompt = `Translate each string in this JSON array into ${LANGS[lang]}. ` + "Keep the meaning exactly. Do not add, remove or soften any instruction, warning, number or unit. " + "Keep names and brands (like BUKO, SwingType, Terry Rowles) unchanged. " + "Return only a JSON array of strings, the same length and order.\n\n" + JSON.stringify(missing);
      const models = [
        Deno.env.get("GEMINI_MODEL"),
        "gemini-3.7-flash",
        "gemini-3.5-flash",
        "gemini-2.5-flash"
      ].filter(Boolean);
      let problem = "Translation is not available right now.";
      let detail = "";
      let out = null;
      const parse = (raw)=>{
        try {
          const arr = JSON.parse(raw.replace(/^\s*```(?:json)?/i, "").replace(/```\s*$/, "").trim());
          return Array.isArray(arr) && arr.length === missing.length && arr.every((x)=>typeof x === "string" && x.trim()) ? arr : null;
        } catch  {
          return null;
        }
      };
      // Every model gets two tries (strict JSON, then plain). Each model has its own free allowance,
      // so a busy or retired model just moves us on to the next one.
      attempts: for (const model of models){
        for (const strict of [
          true,
          false
        ]){
          const r = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent`, {
            method: "POST",
            headers: {
              "x-goog-api-key": key,
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              contents: [
                {
                  parts: [
                    {
                      text: prompt
                    }
                  ]
                }
              ],
              generationConfig: strict ? {
                temperature: 0,
                maxOutputTokens: 8192,
                responseMimeType: "application/json",
                responseSchema: {
                  type: "ARRAY",
                  items: {
                    type: "STRING"
                  }
                }
              } : {
                temperature: 0,
                maxOutputTokens: 8192
              }
            })
          }).catch(()=>null);
          if (!r) {
            detail = `${model}: no connection`;
            break;
          }
          const j = await r.json().catch(()=>({}));
          if (r.ok) {
            const raw = (j?.candidates?.[0]?.content?.parts ?? []).map((p)=>p.text ?? "").join("");
            const arr = parse(raw);
            if (arr) {
              out = arr;
              break attempts;
            }
            detail = `${model}: answer was not a complete list`;
            continue; // try plain mode, then the next model
          }
          detail = `${model}: ${r.status} ${String(j?.error?.message ?? "").slice(0, 200)}`;
          if (r.status === 429) {
            problem = "Translation is busy right now.";
            break;
          } // next model has its own allowance
          if (r.status === 404) break; // retired model name
        // 400 / 403 / 5xx: try plain mode, then the next model
        }
      }
      if (!out) return reply({
        error: problem,
        detail
      });
      const rows = missing.map((t, i)=>({
          source_hash: hashOf.get(t),
          lang,
          source_text: t,
          translated: out[i]
        }));
      rows.forEach((r)=>known.set(r.source_hash, r.translated));
      await db.from("translations_cache").upsert(rows, {
        onConflict: "source_hash,lang",
        ignoreDuplicates: true
      }); // never overwrites a reviewed row
    }
    return reply({
      translations: texts.map((t)=>known.get(hashOf.get(t)))
    });
  } catch (e) {
    return reply({
      error: "Something went wrong: " + String(e?.message ?? e)
    });
  }
});
