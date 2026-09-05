// Supabase Edge Function: delete-video-from-r2
// Deploy: supabase functions deploy delete-video-from-r2
//
// Purpose: deletes one specific video file from R2 immediately, when its
// post is manually deleted (not waiting for the 30-hour expiry cleanup).
// Without this, manually deleting a video removes it from the app but
// leaves the actual file sitting in R2 storage forever, wasting space.
//
// Only the post's own author or an admin can trigger this - same
// permission model already enforced for deleting the post itself.
//
// Request:  POST { "mediaUrl": "https://..." }
// Auth:     Authorization: Bearer <user's JWT>
// Response 200: { "deleted": true }

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { S3Client, DeleteObjectCommand } from "https://esm.sh/@aws-sdk/client-s3@3";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

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

  let mediaUrl: string;
  try {
    const body = await req.json();
    mediaUrl = body.mediaUrl;
    if (!mediaUrl) throw new Error("missing mediaUrl");
  } catch {
    return json({ error: "invalid_request" }, 400);
  }

  // Permission check: the video's key includes the uploader's own user id
  // (pro-voice/<user_id>/<filename>) - only that user, or an admin, may
  // delete it. This mirrors the same rule already enforced for deleting
  // the post itself.
  const supabaseAdmin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );
  const { data: profile } = await supabaseAdmin.from("users").select("role").eq("user_id", userData.user.id).single();
  const isOwnVideo = mediaUrl.includes(`/pro-voice/${userData.user.id}/`);
  if (!isOwnVideo && profile?.role !== "admin") {
    return json({ error: "not_authorized" }, 401);
  }

  const publicBaseUrl = Deno.env.get("R2_PUBLIC_URL")!;
  const key = mediaUrl.replace(`${publicBaseUrl}/`, "");

  const s3 = new S3Client({
    region: "auto",
    endpoint: `https://${Deno.env.get("R2_ACCOUNT_ID")}.r2.cloudflarestorage.com`,
    credentials: {
      accessKeyId: Deno.env.get("R2_ACCESS_KEY_ID")!,
      secretAccessKey: Deno.env.get("R2_SECRET_ACCESS_KEY")!,
    },
  });

  const bucket = Deno.env.get("R2_BUCKET_NAME")!;
  try {
    await s3.send(new DeleteObjectCommand({ Bucket: bucket, Key: key }));
  } catch (err) {
    // Don't block the post deletion just because the file was already
    // gone or something else went wrong deleting it - log it and let
    // the caller proceed either way.
    return json({ deleted: false, error: err.message }, 200);
  }

  return json({ deleted: true }, 200);
});

function json(body: unknown, status: number) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders },
  });
}

// ------------------------------------------------------------
// ACCEPTANCE TESTS (run once deployed - live network access needed)
// ------------------------------------------------------------
// 1. As the video's own owner, call this with its real mediaUrl -> the
//    file is actually gone from R2 (verify in the dashboard)
// 2. As a different non-admin user, try to delete someone else's video
//    -> 401 not_authorized
// 3. As admin, delete any user's video -> succeeds regardless of ownership
