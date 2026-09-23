# BUKO Network — Design System

Reference template for this app's visual language, component patterns, and product rules. Treat it as the source of truth when adding new screens or features — if something isn't covered here, match the spirit of what is.

**v2 — rewritten against the shipped `index.html` / `admin_dashboard.html`.** The previous version of this document was written for an early prototype (then called "My Sports Network") with an in-memory, no-backend build. That prototype has since become a real Supabase-backed product with a working admin dashboard, PWA support, and a fully deterministic assessment engine. Everything below reflects what is actually live today, with explicit notes wherever the shipped product diverges from the earlier plan.

---

## 1. Brand & Positioning

- **Product**: **BUKO Network** (renamed from "My Sports Network / MSN") — an all-sport athlete companion app, launching with **Golf** as the first, and currently only, live vertical.
- **Brand mark**: the **`// |B`** logo — two 15°-forward-slanted "coconut husk" blades paired with an upright, architectural vertical "B" glyph. Locked geometry; only the colorway changes between light/dark.
- **Audience**: athletes aged 13–80. Every design decision is filtered through: *would this work for a 15-year-old and a 72-year-old in the same session?*
- **Tone**: coached, credible, gamified — not clinical, not childish.
- **Architecture intent**: every content table keys off a generic `sport_id`, so a second sport can go live purely by adding a row in the admin's Sports tab — no code refactor. This is now proven, not just planned: adding a sport automatically wires it into polls, news, sponsors, podcast/gear, education, and the Command Center cards.

---

## 2. Color System

All colors are CSS custom properties on `:root`, swappable via `data-` attributes. Never hardcode hex values in components — always reference the variable.

### Core palette (dark mode default)
| Token | Value | Use |
|---|---|---|
| `--bg-app` | `#0A0F1D` | App background |
| `--bg-surface` | `#131D31` | Card surfaces |
| `--bg-card` | `#1A263E` | Nested/secondary cards |
| `--border-subtle` | `#2A3B5C` | Card borders, dividers |
| `--text-main` | `#F8FAFC` | Primary text |
| `--text-muted` | `#94A3B8` | Secondary text |
| `--text-faint` | `#64748B` | Tertiary/meta text |

### Accent (theme-switchable) — updated to BUKO teal
| Token | Dark (Obsidian Teal, default) | Light (Ceramic White) |
|---|---|---|
| `--accent-main` | `#00E5A3` | `#0D9488` |
| `--accent-glow` | `#00B382` | `#0F766E` |
| `--accent-light` | `#5EEFC0` | `#14B8A6` |

**Important, intentional asymmetry**: the light-mode accent is *not* simply a lightened version of the dark accent — it's a deliberately deeper, more saturated teal chosen so the brand color still reads with contrast on a white background. Don't "fix" this by trying to make light/dark mirror each other numerically.

An alternate **Rose** palette still exists and is unchanged from the original design (`--accent-main: #EC4899`, glow `#DB2777`, light `#F472B6`), toggled via `data-palette="rose"` on `<html>`.

### Logo tokens (separate from the general accent system)
| Token | Dark | Light |
|---|---|---|
| `--logo-husk` | `#00E5A3` | `#0D9488` |
| `--logo-glyph` | `#FFFFFF` | `#0F172A` |
| `--logo-bg-from` / `--logo-bg-to` | `#18202F` → `#0A0D15` | `#FFFFFF` → `#E2E8F0` |

These mirror the accent tokens today but are tracked as their own variable set on purpose, so the logo's colorway can be tuned independently of general UI accents if a future rebrand needs it.

### Fixed semantic colors (do not theme-swap)
- **Violet** (`#7C3AED` / light `#A78BFA`) — Fitness segment, Pro Voice/Inner Circle accents. Still deliberately *not* accent-colored, so Fitness never looks like a re-skin of Lessons.
- **Gold/Amber** (`#F59E0B` / light `#FBBF24`) — pricing badges, wallet-points iconography, verified-title badges, "testing mode" warnings in the admin dashboard. Still "achievement or money," consistently.
- **Sponsor red** (`#F40009`) — reserved exclusively for the sponsor brand slot (see §8). Updated from the earlier placeholder `#E8462B`; the rule is unchanged — never reuse this hue for app-native UI.

### Light mode
Full variable swap via `data-theme-mode="light"` remains the mechanism. Confirmed working across every screen, including the logo tokens above.

---

## 3. Typography

- **Font**: Inter, loaded via Google Fonts, weights 300–900. This is the only font actually shipped in `index.html`. (Some later marketing/masthead mockups explored pairing Inter with Plus Jakarta Sans — that pairing never made it into the production app and should be treated as an open idea, not a locked decision.)
- **Minimum body text: 14px (`text-sm`)**, with meta labels/timestamps/badges as the documented exception. In practice, a handful of pure-meta strings (dock clock sub-labels, sponsor "SPONSORED" tags, dynamic-island placeholders) run as small as 10–11px — consistent with the spirit of the exception, never used for anything a user reads for meaning.
- **Font-scale accessibility control**: `--font-scale` (0.92× / 1× / 1.2×) is still live in Profile → Settings and still multiplies root `font-size`.
- **New since v1**: on very large screens the root `font-size` gets two additional bumps independent of the user's own accessibility setting — `106.25%` at ≥1280px and `112.5%` at ≥1680px. These **stack multiplicatively** with `--font-scale`. Anyone testing "Large" text at a 1680px+ viewport should specifically check nothing clips — this combination hasn't had a dedicated QA pass yet.

---

## 4. Touch Targets & Spacing

Unchanged from v1 and confirmed throughout the shipped app:

- **Every interactive element is minimum 48×48px** via `.touch-target` / `min-h-touch` / `min-w-touch`.
- Card padding: `p-4` standard, `p-3` compact.
- Card radius: `rounded-2xl` primary, `rounded-xl` nested, `rounded-full` pills/avatars.
- Vertical rhythm: `space-y-4` (screens), `space-y-3` (within a card).

**One known gap**: several modal `✕` close buttons (Profile, Composer, Report, Registration) render at `w-8 h-8` (32px), not 48px. The Flyer viewer's close button correctly uses 48px. Treat the smaller ones as a backlog fix, not a pattern to copy into new modals.

---

## 5. Iconography — text-first, no icon fonts

Still locked, still true in the shipped code: zero FontAwesome or icon-font CDNs anywhere in `index.html` or `admin_dashboard.html`. Nav and buttons are text-first; compact affordances use plain Unicode (`✕`, `▶`, `➔`, `▾`) or a single emoji (`🌙`/`☀️` theme toggle, `🗳️`, `🎙️`, etc.). If a future contributor adds an icon-font library, that's a regression — flag it in review.

---

## 6. Navigation Pattern — **rewritten (this changed significantly)**

The original two-bar layout (one top row + one row fixed to the bottom) was replaced. Per the code's own comment: the bottom bar caused people to miss **Multi-Sport**, **Command Center**, and **Education**, because they lived in a visually separate, easy-to-overlook spot from the other four tabs.

**Current phone/tablet layout — both rows now live in the top header, stacked:**
- **Row 1 (content):** News, Lessons & Fitness, Pro Voice (has an animated "live" ping dot), Shows & Gear.
- **Row 2 (home/utility):** Multi-Sport, Command Center (default active tab), Education.

`switchTab(tabId)` still just toggles `.tab-page` visibility and re-applies accent classes to `#nav-{tabId}` — this still holds regardless of which physical row a tab's button lives in.

**New: desktop/laptop layout (≥1024px).** Both nav rows collapse into a **single vertical side menu** fixed to the left of the viewport (`clamp(232px, 17vw, 264px)` wide). Rows become stacked icon-less text buttons; the active tab gets a left accent bar + tinted background; social icons relocate from page-bottom to the bottom of the side menu.

**New: iPad-portrait tier (768–1023px wide, ≥600px tall).** Keeps the phone-style stacked top nav, just with wider padding — its own middle tier, not identical to either phone or laptop behavior.

**Global sponsor banner placement is device-specific**: on phones/iPad-portrait it sits above the top nav and slides away on scroll (so it never permanently eats screen height); on desktop it moves to the top of the scrollable page *content* instead, since there's a fixed side nav rather than a fixed header.

**Rule, still true and now battle-tested**: horizontal-scroll-for-more-tabs remains explicitly rejected, in every layout tier — no tab is ever hidden behind an overflow or swipe-to-reveal.

---

## 7. Component Patterns

### Cards
Unchanged: `bg-[var(--bg-surface)] border border-[var(--border-subtle)] rounded-2xl p-4`, with gradient cards reserved for elevated/hero content (Command Center Lessons/Fitness cards, SwingType gate cards).

### Buttons
Unchanged pattern: primary (`theme-accent-bg`), secondary (`bg-[var(--bg-card)]`), destructive (`bg-red-600`), Fitness-specific violet gradient (never accent-colored).

### Badges & Pills
Unchanged pattern (gold/amber for status/streak/price; sponsor tag red-toned, `uppercase`, `text-xs`, paired with the sponsor logo mark).

### Modals
Bottom sheet on mobile / centered card on larger viewports, `animate-slide-up` — confirmed across Profile, Composer, Report, Registration, All Polls, and Article Detail modals. (See the close-button size gap noted in §4.)

### Expiring content (Pro Voice posts)
Fully realized exactly as originally specified: **strict 30-hour visibility window**, identical for Text, Photo, Video, and Voice, no format special-cased. Countdown computed once from `expires_at`, decremented client-side every second via a single global interval, formatted `Xh XXm XXs`. Two audience tiers — 🌐 **Public** and 🔒 **Inner Circle** — every post must pick one.

### Ticket/purchase pattern — **revised from v1**
The original plan called for an in-app, StoreKit-style confirmation sheet before every charge. What actually shipped:
- **Education events**: pay via an *external* link (Stripe / Apple Pay / Google Pay / other checkout) rather than an in-app sheet. Registration itself is free-to-view/register unless an access code is required. **"My Registrations"** is the persistent post-purchase record (the "My Tickets" equivalent).
- **SwingType Assessment ($19)**: unlocked via a dedicated purchase Edge Function (Stripe on web, IAP via Capacitor on native), confirmed with a toast rather than a modal sheet, and the persistent record is the user's own assessed/unlocked state (visible in Command Center + Lessons tab at all times).

**Updated rule**: every purchasable item still needs (1) an explicit, unambiguous confirmation of the outcome (toast or state change — a sheet is no longer required), and (2) a persistent place the user can return to and see what they bought. A purchase that isn't visibly tracked anywhere afterward is still the support-ticket risk this rule exists to prevent.

### New pattern: sponsor blocks have no buttons
If a sponsor placement has a link set, the **entire block itself** is the tappable/clickable target (`role="link"`, Enter-key accessible) — there is never a separate "Learn More" button rendered inside a sponsor slot. This is now a locked, explicit rule.

### New pattern: two-step confirmation for irreversible actions
- **Poll voting** requires *select* (highlights the option) then a separate *Confirm Vote* tap — this exists specifically to prevent a stray tap from casting a permanent vote.
- **Every admin-dashboard write** goes through a shared `confirmAndAcknowledge()` helper: an explicit browser `confirm()` dialog, then a persistent (non-auto-vanishing) on-screen success/failure banner. Any new admin action should follow this same shape rather than a silent save.

---

## 8. Content & Persona Rules

- **No real people for invented/demo UI content** — still a hard rule for any fictional coach, host, or demo user the app itself invents.
- **One exception, and it's intentional**: the SwingType Assessment's "pro comparison" field (*"You move like Rory McIlroy"*) references real, publicly known professional golfers, drawn from real published swing-style analysis, purely as a factual biomechanical-archetype comparison — not a quote, and not an implied endorsement or affiliation. Keep this framing if the feature grows: never attach a fabricated quote to a real name, and never imply sponsorship.
- **Real content partner**: the Podcast segment and the underlying swing-teaching methodology (fold/post types, sway gap, grip checkpoints) are sourced from **Terry Rowles' real coaching content** — this is a genuine content partnership, distinct from the "fictional demo persona" rule above, which still governs any *invented* UI characters elsewhere in the app.
- **One sponsor brand at a time** — confirmed, fully implemented end-to-end as the fictional **"PULSE"** brand, red-toned (`#F40009`), consistent everywhere it appears.
- **Sponsor visual identity stays distinct from product UI** — confirmed: red is reserved for sponsor content only and never reused in app-native chrome.

---

## 9. Accessibility Checklist (apply to every new screen)

- [x] All interactive elements ≥48×48px — **except** several modal `✕` buttons currently at 32px (see §4); don't repeat that gap in new modals.
- [x] No text below 14px except badges/meta (12px floor, occasional 10–11px for pure meta labels)
- [ ] Works at `--font-scale: 1.2` **and** the new large-screen font multipliers stacked together — not yet independently verified; worth a manual pass.
- [x] Works in both light and dark mode (logo tokens included)
- [x] State is never color-only (poll selections, reactions pair color with icon/border/text changes)
- [x] No icon-font dependency
- [x] Every countdown/timer is computed, not hardcoded
- [x] Safe-area-inset handling (notches, home bar, rounded corners) — **new since v1**, applied to the header, main viewport, toasts, the Pro Voice compose FAB, and bottom sheets via `env(safe-area-inset-*)`.

---

## 10. Tech Stack — **rewritten (this was the largest inaccuracy in v1)**

v1 described this as a no-backend, in-memory prototype. That is no longer true.

- **Real backend**: a single shared **Supabase** project (Postgres + Auth + Storage + Edge Functions + RPC) powers both `index.html` and `admin_dashboard.html`. The Supabase URL and anon key are currently hardcoded directly in both files rather than injected via environment config — fine under Supabase's anon-key-plus-RLS model, but worth a deliberate review before wider distribution.
- **Media storage**: Cloudflare R2, uploaded via Supabase Edge Functions (`get-r2-upload-url`, `delete-video-from-r2`) — used for avatars, Pro Voice video/voice/thumbnails, sponsor logos/banners, event flyers, episode thumbnails, and article cover images.
- **PWA**: shipped — `manifest.json`, a service worker (`service-worker.js`) for installability and offline resilience, per-color-scheme `theme-color` meta tags, `apple-touch-icon` + favicon set.
- **Cache-busting**: an `APP_BUILD` string is checked against the live file on every load; on a mismatch it unregisters service workers, clears caches, and reloads once. **Bump this string on every deploy.**
- **Translation subsystem (new)**: a three-tier fallback for both static UI copy and dynamic content — (1) a `translations_cache` Postgres table for instant, free repeat lookups, (2) a private `translate-text` Edge Function (Gemini) for first-time translations, (3) the free public MyMemory API as resilience if Gemini/Supabase is unreachable, with a manual "open Google Translate in a small popup" as the last resort.
- **Native video capture (locked decision)**: Pro Voice video posts use the phone's *native camera app* via a file input's `capture` attribute, deliberately **not** the browser `MediaRecorder` API — `MediaRecorder`'s own output was confirmed unreliable for iOS Safari playback. Don't reintroduce `MediaRecorder` for video without re-solving that problem.
- **Admin dashboard**: its own file, gated by Supabase Auth plus a server-verified `role = 'admin'` check (never trusted client-side alone).
- **Still true from v1**: single-file `index.html` for the main app (no bundler/build step), Tailwind via CDN, Google Fonts (Inter) via `<link>`, Tone.js via CDN for optional SFX (gracefully degrades, respects a user-level Mute preference stored in `localStorage`), no FontAwesome.

---

## 11. Segment Build Status (new — maps the original 7-segment plan to what's actually shipped)

| Original PRD segment | Live tab / location | Status | Monetization actually wired |
|---|---|---|---|
| Online Lessons | Lessons & Fitness → **Lessons** subtab | **Fully built** — deterministic 9-profile SwingType engine (5-question assessment, fold+post scoring matrix, alignment scoring, CMS-driven report/curriculum copy, gear tie-in) | $19 one-time (Stripe/IAP, access code, or admin/testing-mode grant) |
| Online Fitness | Lessons & Fitness → **Fitness** subtab | **Prototype only** — one mock mobility multiple-choice question + a decorative animated canvas; no scoring engine or persistence yet | None |
| Pro Voice Stream | **Pro Voice** | **Fully built** — Text/Photo/Video/Voice, 30h expiry, Public/Inner Circle, 4 fixed emoji reactions, no comments, reporting/moderation, cross-sport `@mentions` (the one deliberate exception) | Free |
| Education Hub | **Education** | **Fully built** — real events, registration, optional access-code lock, external payment links, "My Registrations" | Per-event price, external payment link |
| Media & News | **News** | **Fully built** — two content types: 60-word-cap Briefs + long-form Articles (categories, cover story, byline), with AI-assisted fetch/summarize and fetch/rewrite tools in the admin | Free |
| Podcast Channel | **Shows & Gear** (left column) | **Fully built** — YouTube iframe embed, episode history, Gemini-assisted summaries, translation | Free |
| Equipment & Tech Lab | **Shows & Gear** (right column) | **Fully built** — same engine as Podcast, separate `media_type` | Free |
| *(new, not in original 7)* | **Command Center** | Home dashboard: poll, SwingType status card, Lessons/Fitness previews, Pro Voice preview, News brief preview | n/a |
| *(new, not in original 7)* | **Multi-Sport** | Sport hub selector/switcher — only Golf is live; architecture supports more sports with zero refactor | n/a |

Community Poll and Wallet Points are cross-cutting gamification layered onto Command Center — real, not mocked (per-sport points, +1 daily login, +1 per poll vote), but they aren't one of the original 7 segments.

---

*This document should be updated whenever a new pattern is introduced or an existing rule is deliberately overridden — treat drift between this file and the shipped `index.html`/`admin_dashboard.html` as a decision that needs to be written down, not silently left unresolved.*
