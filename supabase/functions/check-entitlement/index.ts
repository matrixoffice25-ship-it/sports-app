// Supabase Edge Function: check-entitlement
// Deploy: supabase functions deploy check-entitlement
//
// Purpose: single reusable gate for Segments 1 & 2. Never trust client-side
// state for paywall decisions.
//
// CORS: same fix applied here as in delete-account — without handling the
// OPTIONS preflight and returning Access-Control-* headers on every
// response, a browser's fetch() call to this function can silently fail
// with no usable error. This function's calls (inside setActiveSport) don't
// currently show an error to the user on failure, so this bug was likely
// already happening here too, just invisibly — nothing was checking loudly.
//
// Request:  GET /check-entitlement?sport_id=<uuid>&segment=lessons|fitness
// Auth:     Authorization: Bearer <user JWT> (from supabase.auth session)
//
// Response 200: { "entitled": true,  "status": "active", "expires_at": "..." }
// Response 200: { "entitled": false, "status": "expired" }
// Response 401: { "error": "unauthenticated" }
// Response 400: { "error": "missing_params" }

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "GET, OPTIONS",
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  const url = new URL(req.url);
  const sportId = url.searchParams.get("sport_id");
  const segment = url.searchParams.get("segment");

  if (!sportId || !segment || !["lessons", "fitness"].includes(segment)) {
    return json({ error: "missing_params" }, 400);
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

  const { data, error } = await supabaseAdmin.rpc("fn_check_entitlement", {
    p_user_id: userData.user.id,
    p_sport_id: sportId,
    p_segment: segment,
  });

  if (error) return json({ error: "entitlement_check_failed", detail: error.message }, 500);

  return json(data, 200);
});

function json(body: unknown, status: number) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders },
  });
}
