// Supabase Edge Function: get-r2-upload-url
// Deploy: supabase functions deploy get-r2-upload-url
//
// Purpose: generates a short-lived, secure URL that lets a verified user's
// browser upload a video DIRECTLY to Cloudflare R2, without the video ever
// passing through our own server. This is both faster (no double-hop) and
// avoids Edge Function payload size limits, which matter for video files.
//
// Only verified_pro/admin accounts can request one - this is the same
// gate already enforced at the database level for creating posts, applied
// here too since a stray upload URL is still worth restricting.
//
// Request:  POST (no body needed)
// Auth:     Authorization: Bearer <user's JWT>
// Response 200: { "uploadUrl": "...", "publicUrl": "...", "key": "..." }

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { S3Client, PutObjectCommand } from "https://esm.sh/@aws-sdk/client-s3@3";
import { getSignedUrl } from "https://esm.sh/@aws-sdk/s3-request-presigner@3";

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

  const supabaseAdmin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );
  const { data: profile } = await supabaseAdmin.from("users").select("role").eq("user_id", userData.user.id).single();
  if (profile?.role !== "verified_pro" && profile?.role !== "admin") {
    return json({ error: "not_verified" }, 401);
  }

  // Use the browser's ACTUAL recorded format - different phones produce
  // different real formats (iPhones commonly record MP4, Android/Chrome
  // commonly records WebM). Always assuming webm regardless of what was
  // really recorded causes uploads to succeed but fail to play back.
  let contentType = "video/webm"; // sensible fallback if the client didn't specify
  try {
    const body = await req.json();
    if (body?.contentType) contentType = body.contentType;
  } catch {
    // No body provided - fall back to the default above, not a hard error
  }
  const extension = contentType.includes("mp4") ? "mp4" : "webm";

  const accountId = Deno.env.get("R2_ACCOUNT_ID")!;
  const bucket = Deno.env.get("R2_BUCKET_NAME")!;
  const publicBaseUrl = Deno.env.get("R2_PUBLIC_URL")!; // e.g. https://videos.yourdomain.com or the r2.dev URL

  const s3 = new S3Client({
    region: "auto",
    endpoint: `https://${accountId}.r2.cloudflarestorage.com`,
    credentials: {
      accessKeyId: Deno.env.get("R2_ACCESS_KEY_ID")!,
      secretAccessKey: Deno.env.get("R2_SECRET_ACCESS_KEY")!,
    },
  });

  // Unique key per upload - includes the user's id for easy identification
  // if manual cleanup is ever needed, and a random component so nobody can
  // guess/collide with another upload.
  const key = `pro-voice/${userData.user.id}/${crypto.randomUUID()}.${extension}`;

  const command = new PutObjectCommand({ Bucket: bucket, Key: key, ContentType: contentType });
  const uploadUrl = await getSignedUrl(s3, command, { expiresIn: 300 }); // 5 minutes to complete the upload

  return json({
    uploadUrl,
    publicUrl: `${publicBaseUrl}/${key}`,
    key,
  }, 200);
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
// 1. As a non-verified fan, call this -> 401 { error: "not_verified" }
// 2. As verified_pro/admin, call this -> 200 with a real uploadUrl
// 3. PUT a real video file to that uploadUrl -> succeeds (200/204)
// 4. GET the returned publicUrl afterward -> the video plays back
// 5. Wait 6+ minutes, try to PUT to the same (now-expired) uploadUrl ->
//    rejected - confirms the URL genuinely expires as expected
