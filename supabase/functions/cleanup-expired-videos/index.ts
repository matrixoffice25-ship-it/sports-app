// Supabase Edge Function: cleanup-expired-videos
// Deploy: supabase functions deploy cleanup-expired-videos
//
// Purpose: runs on a schedule (see the pg_cron setup in the matching SQL
// file). Finds Pro Voice video posts whose 30-hour window has passed,
// deletes the actual video file from Cloudflare R2, then deletes the
// database row. This is the piece that actually controls video storage
// cost over time - without it, the post "disappears" from the feed but
// the video file sits in R2 forever, quietly accumulating cost.
//
// Triggered by pg_cron with the service role key - not meant to be
// called by end users, so it checks for that specific secret rather
// than a regular user JWT.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { S3Client, DeleteObjectCommand } from "https://esm.sh/@aws-sdk/client-s3@3";

Deno.serve(async (req: Request) => {
  const authHeader = req.headers.get("Authorization") ?? "";
  if (authHeader !== `Bearer ${Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")}`) {
    return new Response(JSON.stringify({ error: "unauthorized" }), { status: 401 });
  }

  const supabaseAdmin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  const { data: expiredVideos, error } = await supabaseAdmin
    .from("pro_posts")
    .select("post_id, media_url")
    .eq("media_type", "Video")
    .lt("expires_at", new Date().toISOString());

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
  if (!expiredVideos || !expiredVideos.length) {
    return new Response(JSON.stringify({ deleted: 0, message: "Nothing to clean up." }), { status: 200 });
  }

  const s3 = new S3Client({
    region: "auto",
    endpoint: `https://${Deno.env.get("R2_ACCOUNT_ID")}.r2.cloudflarestorage.com`,
    credentials: {
      accessKeyId: Deno.env.get("R2_ACCESS_KEY_ID")!,
      secretAccessKey: Deno.env.get("R2_SECRET_ACCESS_KEY")!,
    },
  });

  const bucket = Deno.env.get("R2_BUCKET_NAME")!;
  const publicBaseUrl = Deno.env.get("R2_PUBLIC_URL")!;
  let deletedCount = 0;
  const failures: string[] = [];

  for (const post of expiredVideos) {
    try {
      // The stored media_url is the full public URL - the actual object
      // key inside the bucket is everything after the base URL.
      const key = post.media_url.replace(`${publicBaseUrl}/`, "");
      await s3.send(new DeleteObjectCommand({ Bucket: bucket, Key: key }));
      deletedCount++;
    } catch (err) {
      // One failed deletion should never stop the rest from being cleaned
      // up - log it and keep going, rather than aborting the whole batch.
      failures.push(`${post.post_id}: ${err.message}`);
    }
  }

  // Now that their video files are gone, the posts themselves can be
  // removed via the existing purge function's normal row-deletion logic.
  await supabaseAdmin.rpc("purge_expired_pro_posts");

  return new Response(JSON.stringify({ deleted: deletedCount, failures }), {
    status: 200,
    headers: { "Content-Type": "application/json" },
  });
});

// ------------------------------------------------------------
// ACCEPTANCE TESTS (run once deployed - live network access needed)
// ------------------------------------------------------------
// 1. Call this without the service role key -> 401
// 2. Create a test video post with expires_at in the past, call this
//    with the service role key -> the R2 file is actually deleted
//    (verify in the R2 dashboard) and the database row is gone
// 3. Confirm a NON-expired video post is left completely untouched
