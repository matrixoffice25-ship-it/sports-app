/* BUKO Network service worker — offline resilience + installability.
   Strategy:
   - App shell (index.html + legal pages + manifest + icons): network-first with
     cache fallback, so content updates are picked up immediately when online
     (the app's APP_BUILD mechanism also force-reloads on a build bump).
   - Static CDN assets (Tailwind, fonts): cache-first (immutable-ish, versioned URLs).
   - Supabase & R2 calls: NEVER cached (live data only).
   - YouTube iframes: not interceptable (cross-origin rendering), ignored.
*/

const APP_SHELL = [
  '/',
  '/index.html',
  '/download.html',
  '/privacy-policy.html',
  '/terms-of-service.html',
  '/manifest.json',
  '/icons/favicon-16.png',
  '/icons/favicon-32.png',
  '/icons/apple-touch-icon.png',
  '/icons/pwa-192.png',
  '/icons/pwa-512.png',
  '/icons/maskable-512.png',
];

const CDN_CACHE = 'buko-cdn-v1';
const SHELL_CACHE = 'buko-shell-v1';
const NEVER_HOSTS = [
  'ommgauajjxsswemokuhc.supabase.co',
  '.r2.cloudflarestorage.com',
  'api.stripe.com',
  'generativelanguage.googleapis.com',
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(SHELL_CACHE).then((cache) => cache.addAll(APP_SHELL)).then(() => self.skipWaiting()),
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys.filter((k) => k !== SHELL_CACHE && k !== CDN_CACHE).map((k) => caches.delete(k)),
      ),
    ).then(() => self.clients.claim()),
  );
});

self.addEventListener('fetch', (event) => {
  const req = event.request;
  if (req.method !== 'GET') return;

  const url = new URL(req.url);

  // Live data / paid services: straight to network, never cached or served stale.
  if (NEVER_HOSTS.some((h) => url.hostname.endsWith(h))) return;
  // Navigations: network-first so a fresh deploy is seen instantly.
  if (req.mode === 'navigate') {
    event.respondWith(
      fetch(req)
        .then((res) => {
          const copy = res.clone();
          caches.open(SHELL_CACHE).then((c) => c.put(req, copy));
          return res;
        })
        .catch(() => caches.match(req, { ignoreSearch: true }).then((m) => m || caches.match('/index.html'))),
    );
    return;
  }
  // Our own icons/manifest/pages: stale-while-revalidate.
  if (url.origin === self.location.origin) {
    event.respondWith(
      caches.match(req).then((cached) => {
        const refresh = fetch(req)
          .then((res) => {
            const copy = res.clone();
            caches.open(SHELL_CACHE).then((c) => c.put(req, copy));
            return res;
          })
          .catch(() => cached);
        return cached || refresh;
      }),
    );
    return;
  }
  // CDN assets (Tailwind, Google Fonts): cache-first.
  if (/tailwindcss\.com|fonts\.googleapis\.com|fonts\.gstatic\.com|jsdelivr\.net|esm\.sh/.test(url.hostname)) {
    event.respondWith(
      caches.open(CDN_CACHE).then((cache) =>
        cache.match(req).then(
          (cached) =>
            cached ||
            fetch(req).then((res) => {
              if (res.ok) cache.put(req, res.clone());
              return res;
            }),
        ),
      ),
    );
  }
});