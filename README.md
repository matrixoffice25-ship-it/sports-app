# BUKO Network

Mobile-first web app (single-file `index.html` + a companion internal admin dashboard), backed by a real Supabase project. Tailwind CSS via CDN + vanilla JS — no build step for either front-end file.

> **v2 note**: the previous version of this README described a purely static, no-backend prototype. That's no longer accurate — see "Backend" below before assuming `npx serve .` alone gives you a working app.

## Project files

| File | Purpose |
|---|---|
| `index.html` | The main athlete-facing app (all 7 segments, Command Center, Multi-Sport, Pro Voice, etc.) |
| `admin_dashboard.html` | Internal, Supabase-auth-gated admin tool. Everything content editors touch (news, sponsors, polls, education events, SwingType copy, media, sports) lives here — nothing in `index.html` is meant to be hand-edited in code. |
| `manifest.json`, `service-worker.js`, `icons/` | PWA support — installability + offline resilience. Not included in this repo snapshot; expected alongside `index.html` in production. |
| `terms-of-service.html`, `privacy-policy.html` | Linked from the profile modal and signup flow. |

## Backend

Both `index.html` and `admin_dashboard.html` point at the **same Supabase project**. The project URL and anon key are currently hardcoded directly in both files (`SUPABASE_URL` / `SUPABASE_ANON_KEY` near the top of each `<script>` block) rather than injected via environment variables.

Serving the static files alone (`npx serve .`) will render the app shell, but most panels will show "Could not load…" errors until:
1. A Supabase project exists with the schema below (tables + RLS policies).
2. The Edge Functions and RPC functions below are deployed.
3. `SUPABASE_URL` / `SUPABASE_ANON_KEY` in both HTML files point at that project.

### Tables referenced by the app (schema lives in Supabase, not in this repo)
`users`, `sport_verticals`, `user_sport_profiles`, `news_briefs`, `articles`, `news_categories`, `podcast_episodes`, `sponsor_placements`, `polls`, `poll_options`, `poll_votes`, `education_events`, `education_registrations`, `education_event_access`, `pro_posts`, `pro_post_reactions`, `content_reports`, `title_requests`, `assessment_access_codes`, `translations_cache`, `app_content_labels`.

### Edge Functions the front end calls
`get-r2-upload-url`, `delete-video-from-r2`, `upload-video-to-r2`, `fetch-golf-headlines`, `summarize-news-article`, `rewrite-article-longform`, `summarize-episode`, `translate-text`, `delete-account`, `purchase-swingtype-assessment`.

### RPC (Postgres) functions the front end calls
`get_poll_results`, `increment_wallet_points`, `award_daily_login_point`, `register_for_event`, `redeem_assessment_code`, `get_post_reaction_counts`.

### Media storage
Cloudflare R2, uploaded to via the `get-r2-upload-url` Edge Function. Used for avatars, Pro Voice video/voice clips + thumbnails, sponsor logos/banners, event flyers, episode thumbnails, and article cover images.

## Admin access

There is no self-service signup path for admins. To get in:
1. Create a normal account through `index.html`'s profile modal (or directly in Supabase Auth).
2. In Supabase's **Table Editor**, set that user's row in `users` to `role = 'admin'`.
3. Open `admin_dashboard.html` and sign in with that account's email/password.

`admin_dashboard.html` re-verifies `role = 'admin'` server-side on sign-in (via an RLS-protected read) — it never trusts a client-side flag alone.

## Run locally

```
npx serve .
```
or just open `index.html` directly in a browser. Either way, most content still depends on the Supabase backend described above being live and reachable.

## Deploy

Push to GitHub, then import the repo at vercel.com/new — Vercel auto-detects a static site and deploys on every push to `main`. Because this is a static deploy, the Supabase URL/anon key baked into the HTML travel with it; make sure they point at the intended (staging vs. production) Supabase project before pushing.

**Cache-busting**: bump the `APP_BUILD` constant near the top of each file's `<script>` block on every deploy. Returning users' browsers (and the installed PWA's service worker) compare this string against the live file and auto-clear their cache + reload once if it's changed — skipping this step means some users keep seeing a stale cached copy after a release.

## Design reference

See `DESIGN.md` for the full color system, component patterns, navigation rules, accessibility checklist, and a segment-by-segment build-status table.
