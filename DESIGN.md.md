# My Sports Network — Design System

This is the reference template for this app's visual language, component patterns, and product rules. Treat it as the source of truth when adding new screens or features — if something isn't covered here, match the spirit of what is.

---

## 1. Brand & Positioning

- **Product**: "My Sports Network" (MSN) — an all-sport athlete companion app, launching with Golf as the first live vertical.
- **Audience**: athletes aged 13–80. Every design decision is filtered through: *would this work for a 15-year-old and a 72-year-old in the same session?*
- **Tone**: coached, credible, gamified — not clinical, not childish.

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

### Accent (theme-switchable)
| Token | Emerald (default) | Rose (alt) |
|---|---|---|
| `--accent-main` | `#10B981` | `#EC4899` |
| `--accent-glow` | `#059669` | `#DB2777` |
| `--accent-light` | `#34D399` | `#F472B6` |

Accent drives: primary CTAs, active nav state, progress rings, selected states. Swap via `data-palette="rose"` on `<html>`.

### Fixed semantic colors (do not theme-swap)
- **Violet** (`#7C3AED` / light `#A78BFA`) — Fitness segment, Pro Voice, "inner circle" audience tag. Fitness is deliberately *not* accent-colored so it never looks like a re-skin of Lessons.
- **Gold/Amber** (`#F59E0B` / light `#FBBF24`) — Streaks, XP, SwingType badge, IAP/purchase actions. Gold = "achievement or money," consistently.
- **Sponsor red** (`#E8462B` in the generic-sponsor build) — reserved exclusively for the sponsor brand slot. Never reuse this hue for app-native UI, so sponsor content stays visually distinct from product content at a glance.

### Light mode
Full variable swap via `data-theme-mode="light"` — background goes to near-white (`#F8FAFC`), text inverts, borders lighten. Every component must read both variables, never assume dark.

---

## 3. Typography

- **Font**: Inter, loaded via Google Fonts. Weights 300–900 available; UI mostly uses 600 (semibold)/700 (bold)/800–900 (headings, emphasis).
- **Minimum body text: 14px (`text-sm`)**. Never use sub-14px sizes for anything a user reads for meaning — meta labels, timestamps, and badges are the only exception, and even those should default to `text-sm` where possible.
- **Scale**: `text-sm` (body/meta) → `text-base` (card titles) → `text-lg`/`text-xl` (section headers) → `text-2xl`+ (screen titles).
- **Font-scale accessibility control**: `--font-scale` CSS variable multiplies root `font-size`. User-facing Small/Default/Large control (0.92× / 1× / 1.2×) lives in Profile settings. Because the whole app uses Tailwind's rem-based scale (not arbitrary px), this one variable resizes everything proportionally.

**Rule**: if you're tempted to write `text-[9px]` or `text-[10px]`, stop — use `text-xs` (12px, badges/tags only) or `text-sm` (14px, everything else) instead.

---

## 4. Touch Targets & Spacing

- **Every interactive element is minimum 48×48px**, enforced by the `.touch-target` / `min-h-touch` / `min-w-touch` utility classes. This is non-negotiable for the 13–80 audience — do not ship a tap target smaller than this, including icon-only buttons.
- Card padding: `p-4` standard, `p-3` for compact/secondary cards.
- Card radius: `rounded-2xl` for primary cards, `rounded-xl` for nested elements, `rounded-full` for pills/avatars.
- Vertical rhythm between stacked cards: `space-y-4` (screens), `space-y-3` (within a card).

---

## 5. Iconography — text-first, no icon fonts

**Decision, locked**: the app does not use FontAwesome or any external icon font. Icon fonts render as broken "tofu" boxes when the font fails to load (CDN hiccup, ad blocker, offline) — unacceptable for a 13–80 audience where "the buttons turned into boxes" is a real support ticket, not a rare edge case.

Instead:
- **Nav and buttons are text-first.** A button's label *is* its icon. "Home," "Train," "News" — no glyph needed.
- **Where a compact non-text affordance is truly needed** (record button, close button, play button), use a plain Unicode character (✕, ▶, ✎) or a single emoji (🌙/☀️ for theme toggle). These render from the OS's native font/emoji stack — no external dependency, no failure mode.
- **Never** reintroduce an icon-font library without re-solving this problem. If a future contributor adds `<i class="fa-...">`, that's a regression — flag it in review.

---

## 6. Navigation Pattern

7 core segments, split across two fixed nav bars so all are reachable with zero horizontal scrolling and zero hidden items:

- **Top nav** (in-header, single line, stacked icon-over-label per button): News, Lessons & Fitness, Pro Voice, Shows & Gear.
- **Bottom nav** (fixed, `position: fixed; bottom: 0`): Multi-Sport, Command Center (home), Education.

Active tab state is driven by a single `switchTab(tabId)` function that toggles `.tab-page` visibility and re-applies the accent classes to `#nav-{tabId}` — this pattern holds regardless of which physical bar a tab's button lives in, so tabs can be freely reassigned between top/bottom without touching the JS.

**Rule**: if the segment count ever changes, keep the same top/bottom split logic — don't fall back to a single scrollable row. Horizontal-scroll-for-more-tabs is the one navigation pattern this app explicitly rejects, because off-screen items get zero discovery for users unfamiliar with swipe-to-reveal.

---

## 7. Component Patterns

### Cards
Standard card: `bg-[var(--bg-surface)] border border-[var(--border-subtle)] rounded-2xl p-4`. Gradient cards (`bg-gradient-to-br from-[var(--bg-surface)] to-[var(--bg-card)]`) are reserved for cards that need to feel slightly elevated — hero/featured content, not routine list items.

### Buttons
- Primary action: `theme-accent-bg` (solid accent fill, dark text).
- Secondary action: `bg-[var(--bg-card)]` with `border-[var(--border-subtle)]`.
- Destructive/urgent (recording, live status): solid red (`bg-red-600`).
- Fitness-specific actions: violet gradient (`from-violet-accent to-purple-800`), never accent green — keeps Lessons vs. Fitness visually distinct at a glance.

### Badges & Pills
- Status/streak/XP: gold/amber background at 10–20% opacity, gold text, `rounded-full`.
- Sponsor tag: always paired with the sponsor logo mark, red-toned, `uppercase`, `text-xs`.
- SwingType badge: persistent gold pill in the header, tappable, always visible — it's the one piece of state every other segment reads from.

### Modals
Bottom sheet on mobile (`rounded-t-3xl`, slides up via `.animate-slide-up`), centered card on larger viewports (`sm:rounded-3xl`, `sm:items-center`). Every modal has a `✕` close button, top-right, 48px target.

### Expiring content (Pro Voice posts)
- **Strict 30-hour visibility window, every format, no exceptions.** Text, photo, GIF, and voice posts all expire identically — do not special-case any format.
- Countdown is computed once (`data-seconds="108000"`), decremented client-side every second via a single global interval, and formatted `Xh XXm XXs`. Never hardcode a countdown string — it will drift from reality.
- Two audience tiers: 🌐 Public (all fans) and 🔒 Inner Circle (verified peers only). Every composed post must pick one.

### Ticket/purchase pattern
Every purchasable item (Education Hub masterclasses, etc.) needs: (1) a StoreKit-style confirmation sheet before charging, (2) a persistent "My Tickets" list the user can return to — a purchase that isn't tracked anywhere post-transaction is a support ticket waiting to happen.

---

## 8. Content & Persona Rules

- **No real people.** Coaches, hosts, and demo users are always fictional personas (e.g., Coach Ansel Cruz, Coach Priya Shah, Jordan Blake). Never attribute quotes, titles, or affiliations to real named athletes — this is a hard rule, not a style preference, for trademark/publicity-rights reasons.
- **One sponsor brand at a time.** All sponsor placements — however many, however small — use a single consistent fictional brand identity (logo mark, name, color). Don't mix multiple real or fictional brand names across placements; it reads as inconsistent and, if any name is real, carries the same trademark risk as the persona rule above.
- **Sponsor visual identity stays distinct from product UI.** Sponsor's brand color should not overlap with the app's own accent/violet/gold system — a user should always be able to tell "this is an ad" from color alone, before reading text.

---

## 9. Accessibility Checklist (apply to every new screen)

- [ ] All interactive elements ≥48×48px
- [ ] No text below 14px except badges/tags (12px floor)
- [ ] Works at `--font-scale: 1.2` without clipping or overlap
- [ ] Works in both light and dark mode (test `data-theme-mode="light"`)
- [ ] State is never color-only (pair with icon, checkmark, or text change)
- [ ] No icon-font dependency introduced
- [ ] Every countdown/timer is computed, not hardcoded as static text

---

## 10. Tech Stack Constraints

- Single `index.html` file. No build step, no bundler, no package.json.
- Tailwind via CDN script tag (`cdn.tailwindcss.com`) — config extended inline via `tailwind.config`.
- Google Fonts (Inter) via `<link>` — acceptable external dependency.
- Tone.js via CDN for optional UI sound effects — acceptable, gracefully degrades if blocked (`try/catch` around all `playSfx` calls).
- **No FontAwesome or other icon-font CDN** — see Section 5.
- All state is in-memory JS (no backend in this prototype). When this becomes a real build, `myTickets`, `currentUser`, `dynamicNewsBriefs`, and the composer's post feed are the first candidates for real persistence.

---

*This document should be updated whenever a new pattern is introduced or an existing rule is deliberately overridden — treat divergence from this file as a decision that needs to be written down, not silently made.*
