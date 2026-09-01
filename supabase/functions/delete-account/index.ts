
// Supabase Edge Function: delete-account
// Deploy: supabase functions deploy delete-account
//
// Purpose: lets a user permanently delete their OWN account. This must be an
// Edge Function (not a direct client call) because deleting an auth.users row
// requires the service-role key, which must never be exposed in the browser.
// Deleting the auth.users row cascades automatically to public.users (and
// anything else with a matching on-delete-cascade foreign key), because the
// schema defines users.user_id references auth.users(id) on delete cascade.
//
// CORS: browsers block reading a cross-origin fetch response unless the
// server sends the right Access-Control-* headers, AND they always send a
// preflight OPTIONS request first for calls carrying an Authorization header.
// Without handling both, the browser's fetch() call silently fails/hangs
// with no usable error — this was the actual cause of "Deleting..." never
// finishing. Every response below, including the OPTIONS preflight, must
// include these headers.
//
// Request:  POST /delete-account   (no body needed)
// Auth:     Authorization: Bearer <user JWT>
//
// Response 200: { "deleted": true }
// Response 401: { "error": "unauthenticated" }
// Response 500: { "error": "delete_failed", "detail": "..." }

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

Deno.serve(async (req: Request) => {
  // The browser sends this automatically before the real POST — it must
  // get a 200 with CORS headers or the real request never goes out.
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

  const { error: deleteErr } = await supabaseAdmin.auth.admin.deleteUser(userData.user.id);
  if (deleteErr) return json({ error: "delete_failed", detail: deleteErr.message }, 500);

  return json({ deleted: true }, 200);
});

function json(body: unknown, status: number) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders },
  });
}

// ------------------------------------------------------------
// ACCEPTANCE TESTS
// ------------------------------------------------------------
// 1. Call with no Authorization header -> 401 { error: "unauthenticated" }
// 2. Call with a valid JWT for user A -> 200 { deleted: true }, then confirm
//    in Supabase Auth > Users that user A is gone, AND in Table Editor >
//    users that user A's row is gone too (proves the cascade worked).
// 3. Confirm user B's account is completely untouched after user A's deletion.
// 4. From the actual deployed browser app (not curl/Postman), confirm the
//    button resolves within a couple seconds instead of hanging — this is
//    the real proof the CORS fix worked, since curl never hits CORS at all.
