


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA "pg_catalog";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "public";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."award_daily_login_point"() RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_user_id uuid := auth.uid();
  v_home_sport_id uuid;
  v_last_awarded timestamptz;
  v_new_total int;
begin
  if v_user_id is null then
    return jsonb_build_object('awarded', false, 'reason', 'not_authenticated');
  end if;

  select active_sport_id into v_home_sport_id from users where user_id = v_user_id;
  if v_home_sport_id is null then
    return jsonb_build_object('awarded', false, 'reason', 'no_home_sport');
  end if;

  -- Make sure a row exists for this user+home-sport before checking/updating it
  insert into user_sport_profiles (user_id, sport_id)
  values (v_user_id, v_home_sport_id)
  on conflict (user_id, sport_id) do nothing;

  select last_point_awarded_at into v_last_awarded
  from user_sport_profiles where user_id = v_user_id and sport_id = v_home_sport_id;

  if v_last_awarded is not null and v_last_awarded > now() - interval '24 hours' then
    return jsonb_build_object('awarded', false, 'reason', 'already_awarded_today');
  end if;

  update user_sport_profiles
  set wallet_points = wallet_points + 1, last_point_awarded_at = now()
  where user_id = v_user_id and sport_id = v_home_sport_id
  returning wallet_points into v_new_total;

  return jsonb_build_object('awarded', true, 'sport_id', v_home_sport_id, 'wallet_points', v_new_total);
end;
$$;


ALTER FUNCTION "public"."award_daily_login_point"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."cleanup_expired_pro_posts"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  expired_video record;
  service_key text;
  project_url text := 'https://ommgauajjxsswemokuhc.supabase.co';
begin
  select decrypted_secret into service_key
  from vault.decrypted_secrets
  where name = 'service_role_key'
  limit 1;

  if service_key is null then
    raise notice 'cleanup_expired_pro_posts: service_role_key not found in Vault - skipping R2 file cleanup this run (posts will still be deleted from the database below).';
  else
    -- Best-effort file cleanup for each expired VIDEO post, using the
    -- exact same edge function the app already calls when a video post
    -- is deleted early by hand. Wrapped so one failed HTTP call can
    -- never stop the loop or block the database cleanup below.
    for expired_video in
      select post_id, media_url from pro_posts
      where expires_at < now() and media_type = 'Video' and media_url is not null
    loop
      begin
        perform net.http_post(
          url := project_url || '/functions/v1/delete-video-from-r2',
          headers := jsonb_build_object(
            'Content-Type', 'application/json',
            'Authorization', 'Bearer ' || service_key
          ),
          body := jsonb_build_object('mediaUrl', expired_video.media_url)
        );
      exception when others then
        raise notice 'cleanup_expired_pro_posts: R2 delete call failed for post %, continuing: %', expired_video.post_id, SQLERRM;
      end;
    end loop;
  end if;

  -- Remove the expired rows themselves regardless of whether the R2 file
  -- calls above succeeded - a post that's 30+ hours old must never keep
  -- showing up anywhere, even in an admin query, no matter what.
  delete from pro_posts where expires_at < now();
end;
$$;


ALTER FUNCTION "public"."cleanup_expired_pro_posts"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."fn_check_entitlement"("p_user_id" "uuid", "p_sport_id" "uuid", "p_segment" "text") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
declare
  v_sub subscriptions%rowtype;
begin
  select * into v_sub
  from subscriptions
  where user_id = p_user_id and sport_id = p_sport_id and segment = p_segment
  order by expires_at desc
  limit 1;

  if v_sub is null then
    return jsonb_build_object('entitled', false, 'status', 'none');
  end if;

  if v_sub.status in ('active', 'grace') and v_sub.expires_at > now() - interval '16 days' then
    return jsonb_build_object(
      'entitled', true,
      'status', v_sub.status,
      'expires_at', v_sub.expires_at
    );
  end if;

  return jsonb_build_object('entitled', false, 'status', v_sub.status, 'expires_at', v_sub.expires_at);
end;
$$;


ALTER FUNCTION "public"."fn_check_entitlement"("p_user_id" "uuid", "p_sport_id" "uuid", "p_segment" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_poll_results"("p_poll_id" "uuid") RETURNS TABLE("option_id" "uuid", "vote_count" bigint)
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select option_id, count(*) as vote_count
  from poll_votes
  where poll_id = p_poll_id
  group by option_id;
$$;


ALTER FUNCTION "public"."get_poll_results"("p_poll_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_post_reaction_counts"("p_post_id" "uuid") RETURNS TABLE("emoji" "text", "reaction_count" bigint)
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select emoji, count(*) as reaction_count
  from pro_post_reactions
  where post_id = p_post_id
  group by emoji;
$$;


ALTER FUNCTION "public"."get_post_reaction_counts"("p_post_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."increment_wallet_points"("p_amount" integer) RETURNS integer
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare v_new int;
begin
  update users set wallet_points = wallet_points + p_amount
    where user_id = auth.uid()
    returning wallet_points into v_new;
  return v_new;
end;
$$;


ALTER FUNCTION "public"."increment_wallet_points"("p_amount" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."increment_wallet_points"("p_sport_id" "uuid", "p_amount" integer DEFAULT 1) RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_user_id uuid := auth.uid();
  v_new_total int;
begin
  if v_user_id is null then
    return jsonb_build_object('success', false, 'reason', 'not_authenticated');
  end if;

  insert into user_sport_profiles (user_id, sport_id)
  values (v_user_id, p_sport_id)
  on conflict (user_id, sport_id) do nothing;

  update user_sport_profiles
  set wallet_points = wallet_points + p_amount
  where user_id = v_user_id and sport_id = p_sport_id
  returning wallet_points into v_new_total;

  return jsonb_build_object('success', true, 'sport_id', p_sport_id, 'wallet_points', v_new_total);
end;
$$;


ALTER FUNCTION "public"."increment_wallet_points"("p_sport_id" "uuid", "p_amount" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"() RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists (select 1 from users where user_id = auth.uid() and role = 'admin');
$$;


ALTER FUNCTION "public"."is_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_verified_pro"() RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists (select 1 from users where user_id = auth.uid() and role = 'verified_pro');
$$;


ALTER FUNCTION "public"."is_verified_pro"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."prevent_unapproved_privileged_field_changes"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  old_title text;
  old_role text;
  old_inner_circle boolean;
begin
  if TG_OP = 'INSERT' then
    old_title := null;
    old_role := 'fan';
    old_inner_circle := false;
  else
    old_title := old.title;
    old_role := old.role;
    old_inner_circle := old.inner_circle_access;
  end if;

  if (new.title is distinct from old_title)
     or (new.role is distinct from old_role)
     or (new.inner_circle_access is distinct from old_inner_circle) then
    if not exists (select 1 from users where user_id = auth.uid() and role = 'admin') then
      raise exception 'Only an admin can set title, role, or inner_circle_access. New accounts start as a fan with no title - title changes must go through the approval request flow.';
    end if;
  end if;
  return new;
end;
$$;


ALTER FUNCTION "public"."prevent_unapproved_privileged_field_changes"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."purge_expired_pro_posts"() RETURNS "void"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  delete from pro_posts where expires_at < now() - interval '1 hour';
$$;


ALTER FUNCTION "public"."purge_expired_pro_posts"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."redeem_assessment_code"("p_code" "text", "p_sport_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_uid uuid := auth.uid();
  v_code_row public.assessment_access_codes%rowtype;
begin
  if v_uid is null then
    return false;
  end if;

  select * into v_code_row
  from public.assessment_access_codes
  where code = upper(trim(p_code))
    and sport_id = p_sport_id
    and active = true
    and uses_count < max_uses
  for update;

  if not found then
    return false;
  end if;

  update public.assessment_access_codes
  set uses_count = uses_count + 1
  where code = v_code_row.code;

  insert into public.user_sport_profiles (user_id, sport_id, assessment_purchased, assessment_access_source)
  values (v_uid, p_sport_id, true, 'code')
  on conflict (user_id, sport_id)
  do update set assessment_purchased = true, assessment_access_source = 'code';

  return true;
end;
$$;


ALTER FUNCTION "public"."redeem_assessment_code"("p_code" "text", "p_sport_id" "uuid") OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."education_registrations" (
    "registration_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "event_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'registered'::"text" NOT NULL,
    "registered_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "full_name" "text",
    "email" "text",
    "phone" "text",
    CONSTRAINT "education_registrations_status_check" CHECK (("status" = ANY (ARRAY['registered'::"text", 'cancelled'::"text"])))
);


ALTER TABLE "public"."education_registrations" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."register_for_event"("p_event_id" "uuid", "p_full_name" "text", "p_email" "text", "p_phone" "text", "p_access_code" "text" DEFAULT NULL::"text") RETURNS "public"."education_registrations"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_event education_events;
  v_result education_registrations;
begin
  select * into v_event from education_events where event_id = p_event_id and status = 'published';
  if not found then
    raise exception 'Event not found or not published.';
  end if;

  if v_event.is_locked then
    if p_access_code is null or trim(p_access_code) = '' then
      raise exception 'This event requires an access code to register.';
    end if;
    if lower(trim(p_access_code)) != lower(trim(v_event.access_code)) then
      raise exception 'That access code is not correct.';
    end if;
  end if;

  insert into education_registrations (event_id, user_id, full_name, email, phone, status)
  values (p_event_id, auth.uid(), p_full_name, p_email, p_phone, 'registered')
  on conflict (event_id, user_id) do update set status = 'registered', full_name = excluded.full_name, email = excluded.email, phone = excluded.phone
  returning * into v_result;

  return v_result;
end;
$$;


ALTER FUNCTION "public"."register_for_event"("p_event_id" "uuid", "p_full_name" "text", "p_email" "text", "p_phone" "text", "p_access_code" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."st_is_admin"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists (select 1 from public.users where user_id = auth.uid() and role = 'admin');
$$;


ALTER FUNCTION "public"."st_is_admin"() OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."app_content_labels" (
    "label_key" "text" NOT NULL,
    "value" "text" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."app_content_labels" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."articles" (
    "article_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "category_slug" "text" NOT NULL,
    "title" "text" NOT NULL,
    "dek" "text",
    "body_markdown" "text" NOT NULL,
    "cover_image_url" "text",
    "author_name" "text",
    "author_photo_url" "text",
    "source_url" "text",
    "read_minutes" integer,
    "status" "text" DEFAULT 'draft'::"text" NOT NULL,
    "is_cover_story" boolean DEFAULT false NOT NULL,
    "is_featured" boolean DEFAULT false NOT NULL,
    "published_at" timestamp with time zone,
    "created_by" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "articles_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'published'::"text", 'archived'::"text"])))
);


ALTER TABLE "public"."articles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."assessment_access_codes" (
    "code" "text" NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "max_uses" integer DEFAULT 1 NOT NULL,
    "uses_count" integer DEFAULT 0 NOT NULL,
    "active" boolean DEFAULT true NOT NULL,
    "note" "text",
    "created_by" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."assessment_access_codes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."content_reports" (
    "report_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "post_id" "uuid" NOT NULL,
    "reporter_id" "uuid" NOT NULL,
    "reason" "text" NOT NULL,
    "details" "text",
    "status" "text" DEFAULT 'pending'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "content_reports_reason_check" CHECK (("reason" = ANY (ARRAY['spam'::"text", 'inappropriate'::"text", 'harassment'::"text", 'misinformation'::"text", 'other'::"text"]))),
    CONSTRAINT "content_reports_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'reviewed'::"text", 'actioned'::"text"])))
);


ALTER TABLE "public"."content_reports" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."education_event_access" (
    "event_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "granted_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "granted_by" "uuid"
);


ALTER TABLE "public"."education_event_access" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."education_events" (
    "event_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "sport_id" "uuid",
    "title" "text" NOT NULL,
    "description" "text",
    "participant_info" "text",
    "host_name" "text",
    "event_type" "text" DEFAULT 'workshop'::"text" NOT NULL,
    "price_cents" integer,
    "cover_image_url" "text",
    "is_locked" boolean DEFAULT false NOT NULL,
    "status" "text" DEFAULT 'draft'::"text" NOT NULL,
    "sort_order" integer DEFAULT 100 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "payment_url" "text",
    "payment_provider" "text",
    "access_code" "text",
    "event_datetime" timestamp with time zone,
    CONSTRAINT "education_events_event_type_check" CHECK (("event_type" = ANY (ARRAY['workshop'::"text", 'masterclass'::"text", 'clinic'::"text", 'bootcamp'::"text", 'certification'::"text", 'seminar'::"text", 'course_lecture_series'::"text", 'demo'::"text", 'webinar'::"text", 'conference'::"text", 'panel'::"text", 'hackathon'::"text", 'roundtable'::"text"]))),
    CONSTRAINT "education_events_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'published'::"text"])))
);


ALTER TABLE "public"."education_events" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."episode_chapters" (
    "chapter_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "episode_id" "uuid" NOT NULL,
    "label" "text" NOT NULL,
    "time_seconds" integer NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "episode_chapters_time_seconds_check" CHECK (("time_seconds" >= 0))
);


ALTER TABLE "public"."episode_chapters" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."featured_items" (
    "item_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "slot" "text" NOT NULL,
    "position" integer NOT NULL,
    "image_url" "text",
    "caption" "text",
    "link_url" "text",
    "is_active" boolean DEFAULT true NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "featured_items_position_check" CHECK ((("position" >= 1) AND ("position" <= 4))),
    CONSTRAINT "featured_items_slot_check" CHECK (("slot" = ANY (ARRAY['podcast'::"text", 'gear'::"text"])))
);


ALTER TABLE "public"."featured_items" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."news_briefs" (
    "brief_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "body" "text" NOT NULL,
    "source_url" "text",
    "status" "text" DEFAULT 'published'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "sport_id" "uuid" NOT NULL,
    CONSTRAINT "news_briefs_body_check" CHECK (("char_length"("body") <= 500)),
    CONSTRAINT "news_briefs_status_check" CHECK (("status" = ANY (ARRAY['published'::"text", 'draft'::"text"])))
);


ALTER TABLE "public"."news_briefs" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."news_categories" (
    "slug" "text" NOT NULL,
    "label" "text" NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "sport_id" "uuid"
);


ALTER TABLE "public"."news_categories" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."podcast_episodes" (
    "episode_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "youtube_video_id" "text" NOT NULL,
    "title" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "media_type" "text" DEFAULT 'podcast'::"text" NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "sport_id" "uuid",
    "summary" "text",
    "thumbnail_url" "text"
);


ALTER TABLE "public"."podcast_episodes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."poll_options" (
    "option_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "poll_id" "uuid" NOT NULL,
    "label" "text" NOT NULL,
    "sort_order" integer NOT NULL
);


ALTER TABLE "public"."poll_options" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."poll_votes" (
    "poll_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "option_id" "uuid" NOT NULL,
    "voted_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."poll_votes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."polls" (
    "poll_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "question" "text" NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "created_by" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "priority" integer DEFAULT 100 NOT NULL
);


ALTER TABLE "public"."polls" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."pro_post_reactions" (
    "post_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "emoji" "text" NOT NULL,
    "reacted_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "pro_post_reactions_emoji_check" CHECK (("emoji" = ANY (ARRAY['🙏'::"text", '❤️'::"text", '😂'::"text", '😔'::"text"])))
);


ALTER TABLE "public"."pro_post_reactions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."pro_posts" (
    "post_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "author_id" "uuid" NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "body_text" "text",
    "media_type" "text" DEFAULT 'Text'::"text" NOT NULL,
    "media_url" "text",
    "audience" "text" DEFAULT 'public'::"text" NOT NULL,
    "posted_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "expires_at" timestamp with time zone DEFAULT ("now"() + '30:00:00'::interval) NOT NULL,
    "thumbnail_url" "text",
    "mentioned_user_ids" "uuid"[],
    CONSTRAINT "pro_posts_audience_check" CHECK (("audience" = ANY (ARRAY['public'::"text", 'inner_circle'::"text"]))),
    CONSTRAINT "pro_posts_media_type_check" CHECK (("media_type" = ANY (ARRAY['Text'::"text", 'Photo'::"text", 'Video'::"text", 'Voice'::"text"])))
);


ALTER TABLE "public"."pro_posts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sponsor_placements" (
    "placement_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "placement_key" "text" NOT NULL,
    "sport_id" "uuid",
    "kind" "text" NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "sponsor_name" "text" DEFAULT 'PULSE'::"text" NOT NULL,
    "logo_text" "text" DEFAULT 'PULSE'::"text" NOT NULL,
    "logo_color" "text" DEFAULT '#F40009'::"text" NOT NULL,
    "eyebrow_label" "text",
    "headline" "text",
    "cta_label" "text",
    "cta_url" "text",
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "logo_image_url" "text",
    "banner_image_url" "text",
    "banner_max_height_px" integer,
    "badge_width_px" integer,
    "badge_height_px" integer,
    "banner_max_width_px" integer,
    CONSTRAINT "sponsor_placements_kind_check" CHECK (("kind" = ANY (ARRAY['badge'::"text", 'banner'::"text"])))
);


ALTER TABLE "public"."sponsor_placements" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sport_verticals" (
    "sport_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "slug" "text" NOT NULL,
    "display_name" "text" NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "assessment_label" "text" DEFAULT 'Skill Profile'::"text" NOT NULL,
    "banner_image_url" "text",
    "status_badge_text" "text",
    "is_launched" boolean DEFAULT true NOT NULL,
    "cta_label" "text",
    "admin_only" boolean DEFAULT false NOT NULL,
    "lessons_tab_label" "text" DEFAULT 'Lessons'::"text" NOT NULL,
    "fitness_tab_label" "text" DEFAULT 'Fitness'::"text" NOT NULL,
    "lessons_headline" "text" DEFAULT '15-Min Skills Diagnostic'::"text" NOT NULL,
    "fitness_headline" "text" DEFAULT '15-Min Physical Fitness Screen'::"text" NOT NULL,
    "lessons_preview_title" "text" DEFAULT 'Drills Progress'::"text" NOT NULL,
    "fitness_preview_title" "text" DEFAULT 'Mobility & Fitness'::"text" NOT NULL,
    "lessons_preview_subtitle" "text",
    "fitness_preview_subtitle" "text"
);


ALTER TABLE "public"."sport_verticals" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."subscriptions" (
    "subscription_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "segment" "text" NOT NULL,
    "store" "text" NOT NULL,
    "original_transaction_id" "text" NOT NULL,
    "status" "text" NOT NULL,
    "expires_at" timestamp with time zone NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "subscriptions_segment_check" CHECK (("segment" = ANY (ARRAY['lessons'::"text", 'fitness'::"text"]))),
    CONSTRAINT "subscriptions_status_check" CHECK (("status" = ANY (ARRAY['active'::"text", 'grace'::"text", 'expired'::"text", 'revoked'::"text"]))),
    CONSTRAINT "subscriptions_store_check" CHECK (("store" = ANY (ARRAY['apple'::"text", 'google'::"text"])))
);


ALTER TABLE "public"."subscriptions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."title_requests" (
    "request_id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "requested_title" "text" NOT NULL,
    "status" "text" DEFAULT 'pending'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "reviewed_at" timestamp with time zone,
    "reviewed_by" "uuid",
    CONSTRAINT "title_requests_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'approved'::"text", 'rejected'::"text"])))
);


ALTER TABLE "public"."title_requests" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."translations_cache" (
    "source_hash" "text" NOT NULL,
    "lang" "text" NOT NULL,
    "source_text" "text" NOT NULL,
    "translated" "text" NOT NULL,
    "reviewed" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."translations_cache" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_sport_profiles" (
    "user_id" "uuid" NOT NULL,
    "sport_id" "uuid" NOT NULL,
    "joined_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "wallet_points" integer DEFAULT 0 NOT NULL,
    "last_point_awarded_at" timestamp with time zone,
    "assessment_purchased" boolean DEFAULT false NOT NULL,
    "assessment_profile_id" integer,
    "assessment_completed_at" timestamp with time zone,
    "assessment_retakes_used" integer DEFAULT 0 NOT NULL,
    "assessment_free_access" boolean DEFAULT false NOT NULL,
    "assessment_access_source" "text",
    "assessment_a1" "text",
    "assessment_a2" "text",
    "assessment_a3" "text",
    "assessment_a4" "text",
    "assessment_a5" "text",
    "assessment_alignment_score" integer,
    CONSTRAINT "user_sport_profiles_assessment_profile_id_check" CHECK ((("assessment_profile_id" IS NULL) OR (("assessment_profile_id" >= 1) AND ("assessment_profile_id" <= 9))))
);


ALTER TABLE "public"."user_sport_profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."users" (
    "user_id" "uuid" NOT NULL,
    "display_name" "text" NOT NULL,
    "role" "text" DEFAULT 'fan'::"text" NOT NULL,
    "active_sport_id" "uuid",
    "photo_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "title" "text",
    "inner_circle_access" boolean DEFAULT false NOT NULL,
    "wallet_points" integer DEFAULT 0 NOT NULL,
    "last_point_awarded_at" timestamp with time zone,
    CONSTRAINT "users_role_check" CHECK (("role" = ANY (ARRAY['fan'::"text", 'verified'::"text", 'inner_circle'::"text", 'admin'::"text"]))),
    CONSTRAINT "users_title_check" CHECK ((("title" = ANY (ARRAY['Professional Athlete'::"text", 'Coach'::"text", 'Industry Expert'::"text", 'Athlete'::"text"])) OR ("title" IS NULL)))
);


ALTER TABLE "public"."users" OWNER TO "postgres";


ALTER TABLE ONLY "public"."app_content_labels"
    ADD CONSTRAINT "app_content_labels_pkey" PRIMARY KEY ("label_key");



ALTER TABLE ONLY "public"."articles"
    ADD CONSTRAINT "articles_pkey" PRIMARY KEY ("article_id");



ALTER TABLE ONLY "public"."assessment_access_codes"
    ADD CONSTRAINT "assessment_access_codes_pkey" PRIMARY KEY ("code");



ALTER TABLE ONLY "public"."content_reports"
    ADD CONSTRAINT "content_reports_pkey" PRIMARY KEY ("report_id");



ALTER TABLE ONLY "public"."content_reports"
    ADD CONSTRAINT "content_reports_unique_reporter_post" UNIQUE ("post_id", "reporter_id");



ALTER TABLE ONLY "public"."education_event_access"
    ADD CONSTRAINT "education_event_access_pkey" PRIMARY KEY ("event_id", "user_id");



ALTER TABLE ONLY "public"."education_events"
    ADD CONSTRAINT "education_events_pkey" PRIMARY KEY ("event_id");



ALTER TABLE ONLY "public"."education_registrations"
    ADD CONSTRAINT "education_registrations_event_id_user_id_key" UNIQUE ("event_id", "user_id");



ALTER TABLE ONLY "public"."education_registrations"
    ADD CONSTRAINT "education_registrations_pkey" PRIMARY KEY ("registration_id");



ALTER TABLE ONLY "public"."episode_chapters"
    ADD CONSTRAINT "episode_chapters_pkey" PRIMARY KEY ("chapter_id");



ALTER TABLE ONLY "public"."featured_items"
    ADD CONSTRAINT "featured_items_pkey" PRIMARY KEY ("item_id");



ALTER TABLE ONLY "public"."featured_items"
    ADD CONSTRAINT "featured_items_sport_id_slot_position_key" UNIQUE ("sport_id", "slot", "position");



ALTER TABLE ONLY "public"."news_briefs"
    ADD CONSTRAINT "news_briefs_pkey" PRIMARY KEY ("brief_id");



ALTER TABLE ONLY "public"."news_categories"
    ADD CONSTRAINT "news_categories_pkey" PRIMARY KEY ("slug");



ALTER TABLE "public"."podcast_episodes"
    ADD CONSTRAINT "podcast_episodes_media_type_check" CHECK (("media_type" = ANY (ARRAY['podcast'::"text", 'gear'::"text", 'equipment'::"text"]))) NOT VALID;



ALTER TABLE ONLY "public"."podcast_episodes"
    ADD CONSTRAINT "podcast_episodes_pkey" PRIMARY KEY ("episode_id");



ALTER TABLE ONLY "public"."poll_options"
    ADD CONSTRAINT "poll_options_pkey" PRIMARY KEY ("option_id");



ALTER TABLE ONLY "public"."poll_votes"
    ADD CONSTRAINT "poll_votes_pkey" PRIMARY KEY ("poll_id", "user_id");



ALTER TABLE ONLY "public"."polls"
    ADD CONSTRAINT "polls_pkey" PRIMARY KEY ("poll_id");



ALTER TABLE ONLY "public"."pro_post_reactions"
    ADD CONSTRAINT "pro_post_reactions_pkey" PRIMARY KEY ("post_id", "user_id");



ALTER TABLE ONLY "public"."pro_posts"
    ADD CONSTRAINT "pro_posts_pkey" PRIMARY KEY ("post_id");



ALTER TABLE ONLY "public"."sponsor_placements"
    ADD CONSTRAINT "sponsor_placements_pkey" PRIMARY KEY ("placement_id");



ALTER TABLE ONLY "public"."sport_verticals"
    ADD CONSTRAINT "sport_verticals_pkey" PRIMARY KEY ("sport_id");



ALTER TABLE ONLY "public"."sport_verticals"
    ADD CONSTRAINT "sport_verticals_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."sport_verticals"
    ADD CONSTRAINT "sport_verticals_slug_unique" UNIQUE ("slug");



ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_original_transaction_id_key" UNIQUE ("original_transaction_id");



ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("subscription_id");



ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_user_id_sport_id_segment_key" UNIQUE ("user_id", "sport_id", "segment");



ALTER TABLE ONLY "public"."title_requests"
    ADD CONSTRAINT "title_requests_pkey" PRIMARY KEY ("request_id");



ALTER TABLE ONLY "public"."translations_cache"
    ADD CONSTRAINT "translations_cache_pkey" PRIMARY KEY ("source_hash", "lang");



ALTER TABLE ONLY "public"."user_sport_profiles"
    ADD CONSTRAINT "user_sport_profiles_pkey" PRIMARY KEY ("user_id", "sport_id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");



CREATE INDEX "idx_subscriptions_user" ON "public"."subscriptions" USING "btree" ("user_id");



CREATE UNIQUE INDEX "one_active_episode_per_sport_and_media_type" ON "public"."podcast_episodes" USING "btree" ("sport_id", "media_type") WHERE ("is_active" = true);



CREATE UNIQUE INDEX "one_cover_story_per_sport" ON "public"."articles" USING "btree" ("sport_id") WHERE ("is_cover_story" = true);



CREATE UNIQUE INDEX "sponsor_placement_key_sport_unique" ON "public"."sponsor_placements" USING "btree" ("placement_key", COALESCE("sport_id", '00000000-0000-0000-0000-000000000000'::"uuid"));



CREATE OR REPLACE TRIGGER "enforce_admin_only_fields" BEFORE INSERT OR UPDATE ON "public"."users" FOR EACH ROW EXECUTE FUNCTION "public"."prevent_unapproved_privileged_field_changes"();



ALTER TABLE ONLY "public"."articles"
    ADD CONSTRAINT "articles_category_slug_fkey" FOREIGN KEY ("category_slug") REFERENCES "public"."news_categories"("slug");



ALTER TABLE ONLY "public"."articles"
    ADD CONSTRAINT "articles_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("user_id");



ALTER TABLE ONLY "public"."articles"
    ADD CONSTRAINT "articles_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."assessment_access_codes"
    ADD CONSTRAINT "assessment_access_codes_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."assessment_access_codes"
    ADD CONSTRAINT "assessment_access_codes_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."content_reports"
    ADD CONSTRAINT "content_reports_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."pro_posts"("post_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."content_reports"
    ADD CONSTRAINT "content_reports_reporter_id_fkey" FOREIGN KEY ("reporter_id") REFERENCES "public"."users"("user_id");



ALTER TABLE ONLY "public"."education_event_access"
    ADD CONSTRAINT "education_event_access_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."education_events"("event_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."education_event_access"
    ADD CONSTRAINT "education_event_access_granted_by_fkey" FOREIGN KEY ("granted_by") REFERENCES "public"."users"("user_id");



ALTER TABLE ONLY "public"."education_event_access"
    ADD CONSTRAINT "education_event_access_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."education_events"
    ADD CONSTRAINT "education_events_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."education_registrations"
    ADD CONSTRAINT "education_registrations_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."education_events"("event_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."education_registrations"
    ADD CONSTRAINT "education_registrations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."episode_chapters"
    ADD CONSTRAINT "episode_chapters_episode_id_fkey" FOREIGN KEY ("episode_id") REFERENCES "public"."podcast_episodes"("episode_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."news_briefs"
    ADD CONSTRAINT "news_briefs_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."podcast_episodes"
    ADD CONSTRAINT "podcast_episodes_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."poll_options"
    ADD CONSTRAINT "poll_options_poll_id_fkey" FOREIGN KEY ("poll_id") REFERENCES "public"."polls"("poll_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."poll_votes"
    ADD CONSTRAINT "poll_votes_option_id_fkey" FOREIGN KEY ("option_id") REFERENCES "public"."poll_options"("option_id");



ALTER TABLE ONLY "public"."poll_votes"
    ADD CONSTRAINT "poll_votes_poll_id_fkey" FOREIGN KEY ("poll_id") REFERENCES "public"."polls"("poll_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."poll_votes"
    ADD CONSTRAINT "poll_votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id");



ALTER TABLE ONLY "public"."polls"
    ADD CONSTRAINT "polls_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("user_id");



ALTER TABLE ONLY "public"."polls"
    ADD CONSTRAINT "polls_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."pro_post_reactions"
    ADD CONSTRAINT "pro_post_reactions_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "public"."pro_posts"("post_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."pro_post_reactions"
    ADD CONSTRAINT "pro_post_reactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id");



ALTER TABLE ONLY "public"."pro_posts"
    ADD CONSTRAINT "pro_posts_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."users"("user_id");



ALTER TABLE ONLY "public"."pro_posts"
    ADD CONSTRAINT "pro_posts_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."sponsor_placements"
    ADD CONSTRAINT "sponsor_placements_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."title_requests"
    ADD CONSTRAINT "title_requests_reviewed_by_fkey" FOREIGN KEY ("reviewed_by") REFERENCES "public"."users"("user_id");



ALTER TABLE ONLY "public"."title_requests"
    ADD CONSTRAINT "title_requests_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_sport_profiles"
    ADD CONSTRAINT "user_sport_profiles_sport_id_fkey" FOREIGN KEY ("sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."user_sport_profiles"
    ADD CONSTRAINT "user_sport_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_active_sport_id_fkey" FOREIGN KEY ("active_sport_id") REFERENCES "public"."sport_verticals"("sport_id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Admins can delete sports" ON "public"."sport_verticals" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins can insert sports" ON "public"."sport_verticals" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins can review title requests" ON "public"."title_requests" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins can update sports" ON "public"."sport_verticals" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins delete" ON "public"."articles" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins delete briefs" ON "public"."news_briefs" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins delete categories" ON "public"."news_categories" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins delete chapters" ON "public"."episode_chapters" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins delete episodes" ON "public"."podcast_episodes" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins delete sponsor placements" ON "public"."sponsor_placements" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins insert" ON "public"."articles" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins insert briefs" ON "public"."news_briefs" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins insert categories" ON "public"."news_categories" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins insert chapters" ON "public"."episode_chapters" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins insert episodes" ON "public"."podcast_episodes" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins manage access grants" ON "public"."education_event_access" USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text"))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins manage content labels" ON "public"."app_content_labels" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "Admins manage events" ON "public"."education_events" USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text"))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins manage featured items" ON "public"."featured_items" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "Admins read all briefs" ON "public"."news_briefs" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins read all episodes" ON "public"."podcast_episodes" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins read all sponsor placements" ON "public"."sponsor_placements" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins read everything" ON "public"."articles" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins update" ON "public"."articles" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins update briefs" ON "public"."news_briefs" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins update categories" ON "public"."news_categories" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins update chapters" ON "public"."episode_chapters" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins update episodes" ON "public"."podcast_episodes" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins update sponsor placements" ON "public"."sponsor_placements" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins write content labels" ON "public"."app_content_labels" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Admins write sponsor placements" ON "public"."sponsor_placements" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))));



CREATE POLICY "Anyone can read all sports" ON "public"."sport_verticals" FOR SELECT USING (true);



CREATE POLICY "Anyone can read basic profile info" ON "public"."users" FOR SELECT USING (true);



CREATE POLICY "Anyone can read published events" ON "public"."education_events" FOR SELECT USING ((("status" = 'published'::"text") OR (EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text"))))));



CREATE POLICY "Authors and admins can delete their own posts" ON "public"."pro_posts" FOR DELETE USING ((("author_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text"))))));



CREATE POLICY "Authors and admins can update their own posts" ON "public"."pro_posts" FOR UPDATE USING ((("author_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text"))))));



CREATE POLICY "Inner Circle posts are visible to Inner Circle and admins only" ON "public"."pro_posts" FOR SELECT USING ((("audience" = 'inner_circle'::"text") AND (EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = ANY (ARRAY['admin'::"text", 'inner_circle'::"text"])))))));



CREATE POLICY "Public posts are visible to everyone" ON "public"."pro_posts" FOR SELECT USING (("audience" = 'public'::"text"));



CREATE POLICY "Public reads active episodes" ON "public"."podcast_episodes" FOR SELECT USING (("is_active" = true));



CREATE POLICY "Public reads active featured items" ON "public"."featured_items" FOR SELECT USING (("is_active" = true));



CREATE POLICY "Public reads active sponsor placements" ON "public"."sponsor_placements" FOR SELECT USING (("is_active" = true));



CREATE POLICY "Public reads all episodes" ON "public"."podcast_episodes" FOR SELECT USING (true);



CREATE POLICY "Public reads all sponsor placements" ON "public"."sponsor_placements" FOR SELECT USING (true);



CREATE POLICY "Public reads categories" ON "public"."news_categories" FOR SELECT USING (true);



CREATE POLICY "Public reads chapters" ON "public"."episode_chapters" FOR SELECT USING (true);



CREATE POLICY "Public reads content labels" ON "public"."app_content_labels" FOR SELECT USING (true);



CREATE POLICY "Public reads published articles" ON "public"."articles" FOR SELECT USING (("status" = 'published'::"text"));



CREATE POLICY "Public reads published briefs" ON "public"."news_briefs" FOR SELECT USING (("status" = 'published'::"text"));



CREATE POLICY "Users can request their own title" ON "public"."title_requests" FOR INSERT WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "Users manage their own registrations" ON "public"."education_registrations" USING ((("user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text")))))) WITH CHECK ((("user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text"))))));



CREATE POLICY "Users see their own access grants" ON "public"."education_event_access" FOR SELECT USING ((("user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text"))))));



CREATE POLICY "Users see their own title requests" ON "public"."title_requests" FOR SELECT USING ((("user_id" = "auth"."uid"()) OR (EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = 'admin'::"text"))))));



CREATE POLICY "Verified, Inner Circle, and admin users can post" ON "public"."pro_posts" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."users"
  WHERE (("users"."user_id" = "auth"."uid"()) AND ("users"."role" = ANY (ARRAY['admin'::"text", 'verified'::"text", 'inner_circle'::"text"]))))));



CREATE POLICY "admins manage access codes" ON "public"."assessment_access_codes" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



ALTER TABLE "public"."app_content_labels" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."articles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assessment_access_codes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."content_reports" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "content_reports_admin_all" ON "public"."content_reports" USING ("public"."is_admin"());



CREATE POLICY "content_reports_insert_own" ON "public"."content_reports" FOR INSERT WITH CHECK (("reporter_id" = "auth"."uid"()));



CREATE POLICY "content_reports_select_own" ON "public"."content_reports" FOR SELECT USING (("reporter_id" = "auth"."uid"()));



ALTER TABLE "public"."education_event_access" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."education_events" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."education_registrations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."episode_chapters" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."featured_items" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."news_briefs" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "news_briefs_admin_all" ON "public"."news_briefs" USING ("public"."is_admin"());



CREATE POLICY "news_briefs_select_published" ON "public"."news_briefs" FOR SELECT USING (("status" = 'published'::"text"));



ALTER TABLE "public"."news_categories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."podcast_episodes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."poll_options" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "poll_options_admin_insert" ON "public"."poll_options" FOR INSERT WITH CHECK ("public"."is_admin"());



CREATE POLICY "poll_options_select_all" ON "public"."poll_options" FOR SELECT USING (true);



ALTER TABLE "public"."poll_votes" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "poll_votes_insert_own" ON "public"."poll_votes" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "poll_votes_select_own" ON "public"."poll_votes" FOR SELECT USING ((("auth"."uid"() = "user_id") OR "public"."is_admin"()));



ALTER TABLE "public"."polls" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "polls_admin_insert" ON "public"."polls" FOR INSERT WITH CHECK ("public"."is_admin"());



CREATE POLICY "polls_admin_update" ON "public"."polls" FOR UPDATE USING ("public"."is_admin"());



CREATE POLICY "polls_select_all" ON "public"."polls" FOR SELECT USING (true);



ALTER TABLE "public"."pro_post_reactions" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "pro_post_reactions_delete_own" ON "public"."pro_post_reactions" FOR DELETE USING (("auth"."uid"() = "user_id"));



CREATE POLICY "pro_post_reactions_insert_own" ON "public"."pro_post_reactions" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "pro_post_reactions_select_own" ON "public"."pro_post_reactions" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "pro_post_reactions_update_own" ON "public"."pro_post_reactions" FOR UPDATE USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."pro_posts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."sponsor_placements" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."sport_verticals" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "st_episodes_admin_write" ON "public"."podcast_episodes" TO "authenticated" USING ("public"."st_is_admin"()) WITH CHECK ("public"."st_is_admin"());



CREATE POLICY "st_episodes_read" ON "public"."podcast_episodes" FOR SELECT TO "authenticated", "anon" USING (true);



CREATE POLICY "st_labels_admin_write" ON "public"."app_content_labels" TO "authenticated" USING ("public"."st_is_admin"()) WITH CHECK ("public"."st_is_admin"());



CREATE POLICY "st_labels_read" ON "public"."app_content_labels" FOR SELECT TO "authenticated", "anon" USING (true);



ALTER TABLE "public"."subscriptions" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "subscriptions_select_own" ON "public"."subscriptions" FOR SELECT USING (("auth"."uid"() = "user_id"));



ALTER TABLE "public"."title_requests" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "tr_cache_read" ON "public"."translations_cache" FOR SELECT TO "authenticated" USING (true);



ALTER TABLE "public"."translations_cache" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_sport_profiles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "user_sport_profiles_insert_own" ON "public"."user_sport_profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "user_sport_profiles_select_own" ON "public"."user_sport_profiles" FOR SELECT USING ((("auth"."uid"() = "user_id") OR "public"."is_admin"()));



ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "users manage their own sport profile" ON "public"."user_sport_profiles" USING (("auth"."uid"() = "user_id")) WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "users_admin_all" ON "public"."users" USING ("public"."is_admin"());



CREATE POLICY "users_insert_self" ON "public"."users" FOR INSERT WITH CHECK ((("auth"."uid"() = "user_id") AND ("role" = 'fan'::"text")));



CREATE POLICY "users_update_own" ON "public"."users" FOR UPDATE USING (("auth"."uid"() = "user_id")) WITH CHECK ((("auth"."uid"() = "user_id") AND ("role" = ( SELECT "users_1"."role"
   FROM "public"."users" "users_1"
  WHERE ("users_1"."user_id" = "auth"."uid"()))) AND ("inner_circle_access" = ( SELECT "users_1"."inner_circle_access"
   FROM "public"."users" "users_1"
  WHERE ("users_1"."user_id" = "auth"."uid"()))) AND ("wallet_points" = ( SELECT "users_1"."wallet_points"
   FROM "public"."users" "users_1"
  WHERE ("users_1"."user_id" = "auth"."uid"()))) AND (NOT ("last_point_awarded_at" IS DISTINCT FROM ( SELECT "users_1"."last_point_awarded_at"
   FROM "public"."users" "users_1"
  WHERE ("users_1"."user_id" = "auth"."uid"()))))));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";





GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";














































































































































































GRANT ALL ON FUNCTION "public"."award_daily_login_point"() TO "anon";
GRANT ALL ON FUNCTION "public"."award_daily_login_point"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."award_daily_login_point"() TO "service_role";



GRANT ALL ON FUNCTION "public"."cleanup_expired_pro_posts"() TO "anon";
GRANT ALL ON FUNCTION "public"."cleanup_expired_pro_posts"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."cleanup_expired_pro_posts"() TO "service_role";



GRANT ALL ON FUNCTION "public"."fn_check_entitlement"("p_user_id" "uuid", "p_sport_id" "uuid", "p_segment" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."fn_check_entitlement"("p_user_id" "uuid", "p_sport_id" "uuid", "p_segment" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."fn_check_entitlement"("p_user_id" "uuid", "p_sport_id" "uuid", "p_segment" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_poll_results"("p_poll_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_poll_results"("p_poll_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_poll_results"("p_poll_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."get_post_reaction_counts"("p_post_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_post_reaction_counts"("p_post_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_post_reaction_counts"("p_post_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."increment_wallet_points"("p_amount" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."increment_wallet_points"("p_amount" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."increment_wallet_points"("p_amount" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."increment_wallet_points"("p_sport_id" "uuid", "p_amount" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."increment_wallet_points"("p_sport_id" "uuid", "p_amount" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."increment_wallet_points"("p_sport_id" "uuid", "p_amount" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_verified_pro"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_verified_pro"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_verified_pro"() TO "service_role";



GRANT ALL ON FUNCTION "public"."prevent_unapproved_privileged_field_changes"() TO "anon";
GRANT ALL ON FUNCTION "public"."prevent_unapproved_privileged_field_changes"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."prevent_unapproved_privileged_field_changes"() TO "service_role";



GRANT ALL ON FUNCTION "public"."purge_expired_pro_posts"() TO "anon";
GRANT ALL ON FUNCTION "public"."purge_expired_pro_posts"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."purge_expired_pro_posts"() TO "service_role";



GRANT ALL ON FUNCTION "public"."redeem_assessment_code"("p_code" "text", "p_sport_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."redeem_assessment_code"("p_code" "text", "p_sport_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."redeem_assessment_code"("p_code" "text", "p_sport_id" "uuid") TO "service_role";



GRANT ALL ON TABLE "public"."education_registrations" TO "anon";
GRANT ALL ON TABLE "public"."education_registrations" TO "authenticated";
GRANT ALL ON TABLE "public"."education_registrations" TO "service_role";



GRANT ALL ON FUNCTION "public"."register_for_event"("p_event_id" "uuid", "p_full_name" "text", "p_email" "text", "p_phone" "text", "p_access_code" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."register_for_event"("p_event_id" "uuid", "p_full_name" "text", "p_email" "text", "p_phone" "text", "p_access_code" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."register_for_event"("p_event_id" "uuid", "p_full_name" "text", "p_email" "text", "p_phone" "text", "p_access_code" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."st_is_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."st_is_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."st_is_admin"() TO "service_role";
























GRANT ALL ON TABLE "public"."app_content_labels" TO "anon";
GRANT ALL ON TABLE "public"."app_content_labels" TO "authenticated";
GRANT ALL ON TABLE "public"."app_content_labels" TO "service_role";



GRANT ALL ON TABLE "public"."articles" TO "anon";
GRANT ALL ON TABLE "public"."articles" TO "authenticated";
GRANT ALL ON TABLE "public"."articles" TO "service_role";



GRANT ALL ON TABLE "public"."assessment_access_codes" TO "anon";
GRANT ALL ON TABLE "public"."assessment_access_codes" TO "authenticated";
GRANT ALL ON TABLE "public"."assessment_access_codes" TO "service_role";



GRANT ALL ON TABLE "public"."content_reports" TO "anon";
GRANT ALL ON TABLE "public"."content_reports" TO "authenticated";
GRANT ALL ON TABLE "public"."content_reports" TO "service_role";



GRANT ALL ON TABLE "public"."education_event_access" TO "anon";
GRANT ALL ON TABLE "public"."education_event_access" TO "authenticated";
GRANT ALL ON TABLE "public"."education_event_access" TO "service_role";



GRANT ALL ON TABLE "public"."education_events" TO "anon";
GRANT ALL ON TABLE "public"."education_events" TO "authenticated";
GRANT ALL ON TABLE "public"."education_events" TO "service_role";



GRANT ALL ON TABLE "public"."episode_chapters" TO "anon";
GRANT ALL ON TABLE "public"."episode_chapters" TO "authenticated";
GRANT ALL ON TABLE "public"."episode_chapters" TO "service_role";



GRANT ALL ON TABLE "public"."featured_items" TO "anon";
GRANT ALL ON TABLE "public"."featured_items" TO "authenticated";
GRANT ALL ON TABLE "public"."featured_items" TO "service_role";



GRANT ALL ON TABLE "public"."news_briefs" TO "anon";
GRANT ALL ON TABLE "public"."news_briefs" TO "authenticated";
GRANT ALL ON TABLE "public"."news_briefs" TO "service_role";



GRANT ALL ON TABLE "public"."news_categories" TO "anon";
GRANT ALL ON TABLE "public"."news_categories" TO "authenticated";
GRANT ALL ON TABLE "public"."news_categories" TO "service_role";



GRANT ALL ON TABLE "public"."podcast_episodes" TO "anon";
GRANT ALL ON TABLE "public"."podcast_episodes" TO "authenticated";
GRANT ALL ON TABLE "public"."podcast_episodes" TO "service_role";



GRANT ALL ON TABLE "public"."poll_options" TO "anon";
GRANT ALL ON TABLE "public"."poll_options" TO "authenticated";
GRANT ALL ON TABLE "public"."poll_options" TO "service_role";



GRANT ALL ON TABLE "public"."poll_votes" TO "anon";
GRANT ALL ON TABLE "public"."poll_votes" TO "authenticated";
GRANT ALL ON TABLE "public"."poll_votes" TO "service_role";



GRANT ALL ON TABLE "public"."polls" TO "anon";
GRANT ALL ON TABLE "public"."polls" TO "authenticated";
GRANT ALL ON TABLE "public"."polls" TO "service_role";



GRANT ALL ON TABLE "public"."pro_post_reactions" TO "anon";
GRANT ALL ON TABLE "public"."pro_post_reactions" TO "authenticated";
GRANT ALL ON TABLE "public"."pro_post_reactions" TO "service_role";



GRANT ALL ON TABLE "public"."pro_posts" TO "anon";
GRANT ALL ON TABLE "public"."pro_posts" TO "authenticated";
GRANT ALL ON TABLE "public"."pro_posts" TO "service_role";



GRANT ALL ON TABLE "public"."sponsor_placements" TO "anon";
GRANT ALL ON TABLE "public"."sponsor_placements" TO "authenticated";
GRANT ALL ON TABLE "public"."sponsor_placements" TO "service_role";



GRANT ALL ON TABLE "public"."sport_verticals" TO "anon";
GRANT ALL ON TABLE "public"."sport_verticals" TO "authenticated";
GRANT ALL ON TABLE "public"."sport_verticals" TO "service_role";



GRANT ALL ON TABLE "public"."subscriptions" TO "anon";
GRANT ALL ON TABLE "public"."subscriptions" TO "authenticated";
GRANT ALL ON TABLE "public"."subscriptions" TO "service_role";



GRANT ALL ON TABLE "public"."title_requests" TO "anon";
GRANT ALL ON TABLE "public"."title_requests" TO "authenticated";
GRANT ALL ON TABLE "public"."title_requests" TO "service_role";



GRANT ALL ON TABLE "public"."translations_cache" TO "anon";
GRANT ALL ON TABLE "public"."translations_cache" TO "authenticated";
GRANT ALL ON TABLE "public"."translations_cache" TO "service_role";



GRANT ALL ON TABLE "public"."user_sport_profiles" TO "anon";
GRANT ALL ON TABLE "public"."user_sport_profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."user_sport_profiles" TO "service_role";



GRANT ALL ON TABLE "public"."users" TO "anon";
GRANT ALL ON TABLE "public"."users" TO "authenticated";
GRANT ALL ON TABLE "public"."users" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































