// Supabase Edge Function: upload-video-to-r2
// Deploy: supabase functions deploy upload-video-to-r2
// Rebuilt 2026-10-11 by Pink from admin_dashboard.html's uploadSwingtypeVideoFile()
// call site (multipart upload path — distinct from get-r2-upload-url's direct-PUT path).
//
// Purpose: admin-only. Receives a multipart/form-data upload containing:
//   file        : the video file (MP4/.mov etc.)
//   key_prefix  : logical name, e.g. "swingtype_downswing" — becomes part of the R2 key
// pushes the file into the Cloudflare R2 bucket, and returns the public CDN URL
// the admin dashboard then stores in app_content_labels.
//
// Request:  POST  multipart/form-data { file: <binary>, key_prefix: string }
// Auth:     Authorization: Bearer <admin user JWT>
// Response 200: { "url": "https://<R2_PUBLIC_URL>/<prefix>/<uuid>.<ext>" }
// Response 401: { "error": "unauthenticated" | "not_admin" }

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { S3Client, PutObjectCommand } from "https://esm.sh/@aws-sdk/client-s3@3";

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

function contentTypeToExt(ct: string, fallbackName?: string): string {
  const nameExt = fallbackName?.includes(".")
    ? fallbackName.split(".").pop()!.toLowerCase().replace(/[^a-z0-9]/g, "")
    : null;
  if (nameExt && ["mp4", "mov", "webm", "m4v", "jpg", "jpeg", "png"].includes(nameExt)) return nameExt;
  if (ct.includes("quicktime")) return "mov";
  if (ct.includes("webm")) return "webm";
  if (ct.includes("mp4")) return "mp4";
  if (ct.includes("jpeg")) return "jpg";
  if (ct.includes("png")) return "png";
  return "mp4";
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

  const supabaseAdmin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );
  const { data: profile } = await supabaseAdmin
    .from("users").select("role").eq("user_id", userData.user.id).single();
  if (profile?.role !== "admin") return json({ error: "not_admin" }, 401);

  let file: File | null = null;
  let keyPrefix = "video";
  try {
    const form = await req.formData();
    file = form.get("file") as File | null;
    const prefixRaw = form.get("key_prefix");
    if (prefixRaw) keyPrefix = String(prefixRaw).toLowerCase().replace(/[^a-z0-9_-]/g, "") || "video";
  } catch {
    return json({ error: "invalid_form" }, 400);
  }
  if (!file || !file.size) return json({ error: "missing_file" }, 400);

  const ext = contentTypeToExt(file.type || "", file.name);
  const key = `swingtype/${keyPrefix}/${crypto.randomUUID()}.${ext}`;

  const accountId = Deno.env.get("R2_ACCOUNT_ID")!;
  const bucket = Deno.env.get("R2_BUCKET_NAME")!;
  const publicBaseUrl = Deno.env.get("R2_PUBLIC_URL")!; // e.g. https://videos.yourdomain.com or r2.dev URL

  const s3 = new S3Client({
    region: "auto",
    endpoint: `https://${accountId}.r2.cloudflarestorage.com`,
    credentials: {
      accessKeyId: Deno.env.get("R2_ACCESS_KEY_ID")!,
      secretAccessKey: Deno.env.get("R2_SECRET_ACCESS_KEY")!,
    },
  });

  const bytes = new Uint8Array(await file.arrayBuffer());
  try {
    await s3.send(new PutObjectCommand({
      Bucket: bucket,
      Key: key,
      Body: bytes,
      ContentType: file.type || "application/octet-stream",
    }));
  } catch (e) {
    return json({ error: "r2_put_failed", message: (e as Error).message }, 502);
  }

  return json({ url: `${publicBaseUrl}/${key}` }, 200);
});

// ------------------------------------------------------------
// ACCEPTANCE TESTS (run once deployed)
// ------------------------------------------------------------
// 1. No auth -> 401 unauthenticated
// 2. Non-admin user -> 401 not_admin
// 3. Admin with valid multipart (file + key_prefix=test123) -> 200 { url }
// 4. GET the returned url -> the video plays back
// 5. Missing file -> 400 missing_file