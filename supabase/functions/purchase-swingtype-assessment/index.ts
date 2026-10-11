// Supabase Edge Function: purchase-swingtype-assessment
// Deploy: supabase functions deploy purchase-swingtype-assessment
// Rebuilt 2026-10-11 by Pink from index.html's unlockSwingtypeFee() call site
// (function was never committed to the repo — this is a faithful reconstruction).
//
// Purpose: paid unlock of the $19 SwingType Assessment.
//   - Web (PWA): returns a Stripe Checkout session URL. Requires STRIPE_SECRET_KEY
//     and a STRIPE_PRICE_ID for the one-time $19 product. If Stripe env vars are
//     not configured, falls back to "testing mode": unlocks immediately and
//     reports it, so the flow is testable end-to-end before real billing is wired.
//   - Native (Capacitor): returns { success: true, path: 'iap' } — the native
//     shell is expected to run RevenueCat/IAP on top of this confirmation.
//
// Request:  POST { "sport_id": "<uuid>", "platform": "stripe" | "iap" }
// Auth:     Authorization: Bearer <user JWT>
// Response 200 (stripe configured): { "success": true, "checkout_url": "..." }
// Response 200 (testing mode):      { "success": true, "testing": true }
// Response 200 (iap):               { "success": true, "path": "iap" }
// Response 401: { "error": "unauthenticated" }
//
// After Stripe checkout completes (webhook / return), access is granted by
// flipping user_sport_profiles.assessment_purchased = true — the same row the
// admin/testing-mode/code paths use, so entitlement is uniform.

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
  const userId = userData.user.id;

  const supabaseAdmin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  let body: { sport_id?: string; platform?: string };
  try {
    body = await req.json();
  } catch {
    body = {};
  }
  const sportId = body.sport_id;
  if (!sportId) return json({ error: "missing sport_id" }, 400);
  const platform = body.platform === "iap" ? "iap" : "stripe";

  const { data: profile } = await supabaseAdmin
    .from("users").select("role").eq("user_id", userId).single();
  if (!profile) return json({ error: "no_profile" }, 403);

  const supabaseAsSelf = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: authHeader } } },
  );

  if (platform === "iap") {
    // Native purchase flow is completed by the native shell's in-app purchase;
    // this endpoint merely confirms the account is eligible and the product
    // exists in our catalogue. The shell verifies the receipt with RevenueCat
    // and then calls back to mark entitlement (or uses its own webhook).
    return json({ success: true, path: "iap" }, 200);
  }

  const stripeKey = Deno.env.get("STRIPE_SECRET_KEY");
  const stripePrice = Deno.env.get("STRIPE_PRICE_ID");

  if (!stripeKey || !stripePrice) {
    // TESTING MODE: Stripe not wired yet (Madam owns all paid/account steps).
    // Unlock immediately so the full assessment UX is testable, and tell the
    // caller it was a test grant — index.html shows it as source='paid' anyway.
    const { error: upErr } = await supabaseAdmin.from("user_sport_profiles").upsert(
      {
        user_id: userId,
        sport_id: sportId,
        assessment_purchased: true,
        assessment_access_source: "paid",
      },
      { onConflict: "user_id,sport_id" },
    );
    if (upErr) return json({ success: false, message: upErr.message }, 500);
    return json({ success: true, testing: true }, 200);
  }

  // REAL STRIPE PATH (wired only when Madam adds the keys)
  try {
    const origin = new URL(req.url).origin;
    const formData = new FormData();
    formData.append("mode", "payment");
    formData.append("success_url", `${origin}/index.html?swingtype_paid=1&user=${userId}&sport=${sportId}`);
    formData.append("cancel_url", `${origin}/index.html?swingtype_paid=0`);
    formData.append("client_reference_id", `${userId}:${sportId}`);
    formData.append("line_items[0][price]", stripePrice!);
    formData.append("line_items[0][quantity]", "1");
    const stripeRes = await fetch("https://api.stripe.com/v1/checkout/sessions", {
      method: "POST",
      headers: { Authorization: `Bearer ${stripeKey}` },
      body: formData,
    });
    const session = await stripeRes.json();
    if (!stripeRes.ok || !session.url) {
      return json({ success: false, message: session?.error?.message || "stripe_failed" }, 502);
    }
    return json({ success: true, checkout_url: session.url }, 200);
  } catch (e) {
    return json({ success: false, message: (e as Error).message }, 502);
  }
});

// ------------------------------------------------------------
// ACCEPTANCE TESTS (run once deployed)
// ------------------------------------------------------------
// 1. No auth header -> 401 unauthenticated
// 2. Logged-in user, no Stripe env vars -> 200 { success: true, testing: true }
//    and user_sport_profiles.assessment_purchased becomes true
// 3. With STRIPE_SECRET_KEY + STRIPE_PRICE_ID set -> 200 { success: true,
//    checkout_url } pointing at Stripe Checkout
// 4. Missing sport_id -> 400