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
// Request:  POST /delete-account   (no body needed)
// Auth:     Authorization: Bearer <user JWT>
//
// Response 200: { "deleted": true }
// Response 401: { "error": "unauthenticated" }
// Response 500: { "error": "delete_failed", "detail": "..." }

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

Deno.serve(async (req: Request) => {
  const authHeader = req.headers.get("Authorization") ?? "";
  const jwt = authHeader.replace("Bearer ", "");
  if (!jwt) return json({ error: "unauthenticated" }, 401);

  // Verify the caller's own identity from their JWT — this is what makes it
  // safe: a user can only ever trigger deletion of their OWN account, never
  // anyone else's, because userData.user.id comes from their verified token,
  // not from anything the client could pass in a request body.
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
    headers: { "Content-Type": "application/json" },
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
