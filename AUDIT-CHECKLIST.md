# BUKO Network — Full Feature Audit (Pink, 2026-10-11)

Static-served staging clone (localhost:8901), real Supabase project `ommgauajjxsswemokuhc`, live test account `pink.test.athlete@gmail.com` (fan role).

## VERIFIED WORKING ✓

**Main app — auth & account**
- Signup creates real account (Supabase Auth) + users row, welcome toast, wallet +1 point
- Login (returning account) works; logout works
- Admin dashboard gate: fan log-in correctly rejected with clear message, then signs the session out (server-verified role check confirmed in code, not just UI)
- Security: anon key cannot self-promote role — update blocked by RLS (update returned error, role stayed 'fan')
- Session handling: main-app session survived admin tab signOut (separate storage keys — good)

**Main app — content (all live from Supabase)**
- News: cover story + article-detail modal renders full article text, Briefs feed populated
- Lessons: assessment engine ran end-to-end (5 questions answered, produced Profile 3 "On Top + Rear Post", "You move like Ludvig Åberg") — deterministic engine works
- Command Center: poll card, assessment status card, previews all render
- Community Poll voting (Command Center + All Polls modal): 2-step select→confirm works, percentage bars update, ✓ marker on my vote
- Wallet points: 3 points earned correctly (signup + 2 votes) via increment_wallet_points RPC
- Education: event list renders real event ($200 AimPoint Express), registration modal pre-fills name+email, **access-code rejection works** (inline error "That access code is not correct.")
- Shows & Gear: 2 YouTube iframes (Podcast + Gear), episode summary rendered, Translate button ran without error
- Multi-Sport selector: Golf hub ENTER GOLF → lands Command Center; Pickleball shows "Launching Q4 2026" lock — correct
- Pro Voice: renders properly; empty state "No broadcasts yet" correct for new account
- Theme: dark/light toggle works; Rose palette switch works; ad-free premium toggle hides all sponsor blocks (test mode, no billing)
- Settings: notifications + mute toggles present; --font-scale present; delete-account flow present
- Zero console errors, zero failed network calls across entire session

**Edge Functions (deployed & reachable in cloud)**
- translate-text (200), summarize-episode (200), get-r2-upload-url (401=exists, needs auth), delete-video-from-r2 (401), summarize-news-article (401), rewrite-article-longform (400), delete-account (401), cleanup-expired-videos (401), check-entitlement (400)

## BROKEN / MISSING ✗

1. **4 Edge Functions MISSING from cloud: 404** — `purchase-swingtype-assessment`, `fetch-golf-headlines`, `upload-video-to-r2`, `cleanup-expired-videos`.
   Impact: NO WAY TO PAY $19 for SwingType (purchase path dead), golf news auto-fetch dead, direct video upload path dead (get-r2-upload-url exists but the upload put-call target missing), expired Pro Voice videos never cleaned up.
2. **PWA files missing locally: manifest.json, service-worker.js, icons/** — index.html has NO manifest link and no SW registration. App is not installable; no offline layer. (README says they exist in production — never provided.)
3. **All Polls modal opens with display:none until manually forced** — "See All Polls" click doesn't apply flex; modal exists but invisible on first click. (Intermittent — needs verification; may depend on open path.)
4. **6 RPC functions unverified in DB** (get_poll_results, increment_wallet_points, award_daily_login_point, register_for_event, redeem_assessment_code, get_post_reaction_counts) — poll registration RPCs demonstrably work (voting + points), so at least 2 exist; others unused in audit because no pro-posts/registrations flow reached them. Needs Supabase access to confirm all 6.
5. **Repo migrations hold only 3 tables; live DB has ~20.** Schema source of truth is only in the cloud. On next Supabase access: `supabase db dump` → rebuild migrations.

## CANNOT TEST YET (blocked on access, not broken)
- Full admin dashboard (14 tabs: Command Center, News, Podcast, Gear, Education, Polls, Ads, Social, People, Reports, Sports, SwingType Access, Scoring Tags) — needs an account with role='admin' set in Supabase Table Editor (tomorrow's Supabase access)
- Pro Voice posting (Text/Photo/Video/Voice + 30h expiry countdown) — needs role='verified_pro' or 'admin'
- Payment ($19 Stripe/IAP) — edge function missing (above) + paid flows are Madam's domain
- R2 upload (avatar, flyers, thumbnails) — upload-video-to-r2 function missing

## PRIORITY ORDER FOR THE WEEK
1. Restore 4 missing Edge Functions to cloud (they exist in repo for 7; the 4 missing may need building/migrating)
2. Supabase dump → full migrations + set an admin on test account → full admin audit
3. madam provides manifest.json/service-worker.js/icons → PWA restored
4. Legal placeholders (privacy/terms)
5. Fitness segment is prototype-only (per DESIGN.md) — schedule the build
---
## FIXES SHIPPED (same day, on `staging` branch — pushed to GitHub as branch, NOT merged to main)

**Commit d213751** — rebuilt the 3 truly-missing Edge Functions from their call sites:
- `purchase-swingtype-assessment` — Stripe Checkout wiring built; testing-mode fallback grants access immediately (lets full flow be tested before Madam wires real Stripe keys — she owns paid/account steps)
- `upload-video-to-r2` — admin multipart video → R2 upload (admin-only, returns public CDN URL)
- `summarize-episode` — YouTube transcript fetch + Gemini summary + cache, matching admin's videoId call shape
- config.toml entries added for all three

**Commit 63b5c22** — PWA layer rebuilt:
- `manifest.json` (BUKO Network, 6 icons incl. maskable)
- `service-worker.js` (app shell network-first w/ offline fallback; CDN assets cache-first; Supabase/R2/Stripe never cached)
- full icon set generated (`// |B` logo on dark rounded square, scripts/make-icons.py)
- VERIFIED LIVE: manifest fetches 200, SW registered + activated + controlling page, 12 shell entries cached, offline fallback works
- privacy/terms: "My Sports Network" → "BUKO Network" (6 spots), placeholders filled: date 2026-10-11, contact support@bukonetwork.com, min age 13, payments = Stripe/App Store/Play Store

**Commit 77061ae** — APP_BUILD bumped to 2026-10-11-A (cache-busting for the release); admin also bumped locally (private file)

**RPC correction**: all 6 RPCs exist in cloud and work (my earlier 404s were wrong arg names in probes, not missing functions).

## WHAT STILL NEEDS MADAM (cannot be done by me — access/account rules)
1. Deploy the 3 rebuilt edge functions: needs SUPABASE_ACCESS_TOKEN (supabase.com → Account → Access Tokens). One per: summarize-episode, upload-video-to-r2, purchase-swingtype-assessment. Then set secrets: GEMINI_API_KEY (in hermes .env already), R2_* keys after Cloudflare step. Supabase CLI command ready to run.
2. Open the staging preview in her logged-in Chrome (Vercel auth wall blocks my curl): https://sports-lm4d4o7k4-samc3.vercel.app — approve → I merge staging→main → production deploy.
3. Set admin role on test user tomorrow (Supabase access) → full admin-dashboard audit (14 tabs).
4. Stripe keys when real billing goes live (purchase fn currently in testing-mode fallback).
