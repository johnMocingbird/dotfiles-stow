// Compatibility Prefix
const {
    Clipboard,
    Front,
    Hints,
    Normal,
    RUNTIME,
    Visual,
    aceVimMap,
    addSearchAlias,
    cmap,
    getClickableElements,
    imap,
    imapkey,
    iunmap,
    map,
    mapkey,
    readText,
    removeSearchAlias,
    tabOpenLink,
    unmap,
    unmapAllExcept,
    vmapkey,
    vunmap
} = api;

const maps = {}

// Leader key for global shortcuts
const L = '<Space>';

// =============================================================================
// === Settings ===
// =============================================================================
Hints.setCharacters('asdfgyuiopqwertnmzxcvb');
settings.defaultSearchEngine = 'd';
settings.hintAlign = 'left';
settings.omnibarPosition = 'bottom';
settings.focusFirstCandidate = false;
settings.focusAfterClosed = 'last';
settings.scrollStepSize = 200;
settings.tabsThreshold = 0;
settings.modeAfterYank = 'Normal';
settings.richHintsForKeystroke = 500;   // keep the popup, just restyled

// =============================================================================
// === Theme ===
// =============================================================================
settings.theme = `
/* ─── base theme ───────────────────────────────────────────────────── */
#sk_keystroke{
  left:50%!important; bottom:50%!important;
  transform:translate(-50%,50%);
  font-size:22px !important;
  padding:12px 16px;
}
#sk_keystroke kbd{ font-size:24px !important; }

/* ─── keystroke popup polish ───────────────────────────────────────── */
#sk_keystroke {
  /* container */
  background : rgba(20,20,20,.92) !important;   /* softer black  */
  color      : #E6F2FF            !important;   /* light-cyan text */
  border     : 1px solid #3A3A3A  !important;
  border-radius: 8px              !important;
  padding    : 14px 18px          !important;
  font-family: "SF Mono", Menlo, monospace !important;
  line-height: 1.35;
  box-shadow : 0 4px 14px rgba(0,0,0,.45) !important;
}
/* every <kbd> tag (the key blocks) */
#sk_keystroke kbd {
  background : #111               !important;
  color      : #FF5555            !important;   /* red key label */
  border     : 1px solid #555     !important;
  border-radius: 4px              !important;
  padding    : 2px 6px            !important;
  font-size  : 24px               !important;
  margin-right: 8px               !important;
}
/* description text after each key */
#sk_keystroke .annotation {
  display    : flex;
  align-items: center;
  margin     : 0 0 6px 0;
}
/* last item: trim bottom gap */
#sk_keystroke .annotation:last-child { margin-bottom: 0; }

/* ─── enlarge kbd capsule so text fits ────────────────────────────── */
#sk_keystroke kbd{
  display:inline-block;      /* let padding widen the box            */
  white-space:pre;           /* keep "<Space>" as one chunk           */
  padding:4px 10px 5px;      /* ↑ extra vertical + horizontal room    */
  line-height:1.1 !important;/* tighten baseline, avoid clipping      */
}
/* optional: if keys feel too tall after the change, nudge the font   */
#sk_keystroke kbd{ font-size:22px !important; }   /* or 20 / 24 px    */
`;

// =============================================================================
// === Search Engines ===
// =============================================================================
removeSearchAlias('b', 's');
removeSearchAlias('d', 's');
removeSearchAlias('g', 's');
removeSearchAlias('h', 's');
removeSearchAlias('w', 's');
removeSearchAlias('y', 's');
removeSearchAlias('s', 's');

addSearchAlias('ama', 'amazon', 'https://www.amazon.com/s?k=', 's');
addSearchAlias('ap', 'arch pkg', 'https://www.archlinux.org/packages/?sort=&q=', 's');
addSearchAlias('aur', 'aur', 'https://aur.archlinux.org/packages/?O=0&SeB=nd&K=', 's');
addSearchAlias('aw', 'arch wiki', 'https://wiki.archlinux.org/index.php?title=Special:Search&search=', 's');
addSearchAlias('d',  'ddg', 'https://duckduckgo.com/?q=', 's');
addSearchAlias('dh', 'docker', 'https://hub.docker.com/search?type=image&q=', 's');
addSearchAlias('fh', 'flathub', 'https://flathub.org/apps/search/', 's');
addSearchAlias('gh', 'github', 'https://github.com/search?q=', 's');
addSearchAlias('pdb', 'proton', 'https://www.protondb.com/search?q=', 's');
addSearchAlias('r', 'reddit', 'https://libreddit.spike.codes/r/', 's');
addSearchAlias('st', 'steam', 'https://store.steampowered.com/search/?term=', 's');
addSearchAlias('wiki', 'wikipedia', 'https://en.wikipedia.org/wiki/Special:Search/', 's');
addSearchAlias('y', 'yt', 'https://invidious.snopyta.org/search?q=', 's');

// =============================================================================
// === Unmappings ===
// =============================================================================
// --- Default overrides ---
unmap('R');          // drop old history-forward override for remapping
unmap('ge');         // drop default “Go Extension” shortcut
unmap('^');          // drop default scroll-leftmost for remapping
unmap('e');          // edit url
// --- Proxy ---
unmap('spa');
unmap('spb');
unmap('spc');
unmap('spd');
unmap('sps');
unmap('cp');
unmap(';cp');
unmap(';ap');
// --- Misc ---
unmap('gs');
unmap(';t');
unmap('si');
unmap('ga');
unmap('gc');
unmap('gn');
unmap('gr');
unmap('ob');
unmap('og');
unmap('od');
unmap('oy');
unmap('m'); // marks TODO: do i want this
// --- Emoji ---
iunmap(":");

// =============================================================================
// === Mappings ===
// =============================================================================
// --- Hints ---
map('F', 'C');          // Open Hint in new tab
map('<Alt-f>', 'cf');   // Open Multiple Links
map('<Alt-y>', 'ya');   // Yank Link URL
map('<Alt-u>', 'ya');   // Yank Link URL (alt)

// --- Navigation & Scrolling ---
map('H', 'S');          // History Back
map('L', 'D');          // History Forward (was R)
map('R', 'L');          // R now inherits the *default* regional-hints
map('K', ']]');         // Next Page
map('J', '[[');         // Prev Page (Vim-style)

mapkey('d', 'Scroll page down', () => Normal.scroll("pageDown"));
mapkey('u', 'Scroll page up',   () => Normal.scroll("pageUp"));
mapkey("<Ctrl-d>", "Scroll down", () => { Normal.scroll("pageDown"); });
mapkey("<Ctrl-u>", "Scroll up", () => { Normal.scroll("pageUp"); });
map('<Ctrl-b>', 'U');   // scroll full page up
mapkey('^', '#scroll-leftmost', 'Normal.scroll("leftmost")', {repeatIgnore: true});

// --- URL / OmniBar ---
map('o', 'go');         // Open a URL in current tab
map('O', ';U');         // Edit current URL, and open in same tab
map('ge', ';U');        // Edit current URL, and open in same tab (g-e style)
map('T', ';u');         // Edit current URL, and open in new tab
mapkey('p', "Open clipboard URL in current tab", () => { Clipboard.read(res => window.location.href = res.data); });
map('P', 'cc');         // Open clipboard URL in new tab

// --- Tabs ---
map('b', 'T');          // Choose a buffer/tab
map('D', 'x');          // Close current tab
map('>', '>>');         // Move Tab Right
map('<', '<<');         // Move Tab Left
map('<Alt-k>', 'E');    // Tab Next/Prev (Prev is default Alt-j)

// --- Misc ---
map('y', 'yy');         // Yank URL w/ one press
map('gf', 'w');         // Change focused frame
mapkey('gF', '#12Open Chrome Flags', () => { tabOpenLink("chrome://flags/"); });


// =============================================================================
// === Helper Functions for Site-Specific Mappings ===
// =============================================================================

/* 1. GitHub helpers */
function repoRoot() {
  const m = location.href.match(/^https:\/\/github\.com\/[^\/]+\/[^\/]+/);
  return m ? m[0] : null;
}
function openSection(section = '') {
  const base = repoRoot();
  if (base) window.open(`${base}${section && '/' + section}`, '_self');
}

/* 2. Shopify helpers */
function goShopify(path) {
  window.open(path, '_self');
}

/* 3. Shortcut Git-Helpers (v3) */
const SHORTCUT = { url: /https:\/\/app\.shortcut\.com\/mymoc\/story\// };
const OPENER  = 'button[data-on-click="openGitHelpers"]';
const POPUP   = '#git-branch-dialog, .git-branch-dialog';
const FIELD_BRANCH  = '.git-branch';
const FIELD_CMD     = '.git-branch-command';

function waitFor(sel, t = 2500, step = 50) {
  return new Promise(res => {
    const s = performance.now();
    const id = setInterval(() => {
      const el = document.querySelector(sel);
      if (el) { clearInterval(id); res(el); }
      else if (performance.now() - s > t) { clearInterval(id); res(null); }
    }, step);
  });
}

async function copyText(fieldSel, toast) {
  let popup = document.querySelector(POPUP);
  if (!popup) {
    const opener = await waitFor(OPENER);
    if (!opener)   return Front.showPopup('❗ Git icon not found');
    opener.click();
    popup = await waitFor(POPUP);
    if (!popup)    return Front.showPopup('❗ Git popup failed');
  }
  const field = await waitFor(fieldSel);
  if (!field)      return Front.showPopup('❗ Field not found');
  const text = 'value' in field ? field.value : field.textContent.trim();
  Clipboard.write(text);
  Front.showPopup(toast);
}

// =============================================================================
// === Site-Specific Mappings ===
// =============================================================================

/* ───── Browser-specific: Safari vs others ───── */
const isSafari = /Safari/.test(navigator.userAgent) && !/Chrome|Chromium|Edg/i.test(navigator.userAgent);
if (isSafari) {
    // Safari → keep built-in “T” (SurfingKeys default), only change `t`
    unmap('t');
    mapkey('t', 'Open dashboard', () => tabOpenLink('https://esthing64.github.io/my_dashboard/'));
} else {
    // Other browsers → `T` = tab-picker, `t` = dashboard
    unmap('t'); unmap('T');
    mapkey('T', 'Choose a tab (fuzzy finder)', () => Front.openOmnibar({ type: 'Tabs' }));
    mapkey('t', 'Open dashboard', () => tabOpenLink('https://esthing64.github.io/my_dashboard/'));
}

/* ───── app.shortcut.com ───── */
if (/^app\.shortcut\.com$/.test(location.hostname) && location.pathname.startsWith('/mymoc/')) {
  mapkey(`${L}B`, '🌿 Copy branch name', () => copyText(FIELD_BRANCH,  'Branch name copied!'));
  mapkey(`${L}C`, '⌘ Copy checkout cmd', () => copyText(FIELD_CMD,     'Checkout cmd copied!'));
}

/* ───── Mocingbird Admin ───── */
const adminHost = location.hostname;
const ADMIN_RE  = /^(s-admin|admin|d-admin)\.mocingbird\.com$/;
if (ADMIN_RE.test(adminHost)) {
  const PORT = adminHost.startsWith('d-admin') ? ':3000' : '';
  const BASE = adminHost.includes('d-admin') ? `http://${adminHost}${PORT}` : `https://${adminHost}`;
  function g(path){ window.open(`${BASE}/admin/${path}`, '_self'); }

  mapkey(`${L}u`, '👥  Admin → Users',         () => g('users'));
  mapkey(`${L}l`, '📄  Admin → Licenses',      () => g('state_licenses'));
  mapkey(`${L}r`, '🛠  Admin → Roles',         () => g('roles'));
  mapkey(`${L}o`, '🏢  Admin → Organizations', () => g('organizations'));

  if (location.pathname === '/admin/users') {
    mapkey(`${L}f`, '🔎  Admin → Filter User', () => {
      Front.showPrompt('Username', (username) => {
        const url = new URL(location.href);
        url.searchParams.set('q[username_cont]', username);
        url.searchParams.set('commit', 'Filter');
        url.searchParams.set('order', 'id_desc');
        window.open(url.toString(), '_self');
      });
    });
  }
}

/* ───── github.com ───── */
const GITHUB = {domain: /github\.com/};
mapkey(`${L}c`, 'Code tab',      () => openSection(),      GITHUB);
mapkey(`${L}p`, 'Pull requests', () => openSection('pulls'), GITHUB);
mapkey(`${L}w`, 'Wiki',          () => openSection('wiki'),  GITHUB);
mapkey(`${L}s`, 'Stars',         () => openSection('stargazers'), GITHUB);
mapkey(`${L}f`, 'Go to Front-end repo', () => window.open('https://github.com/MyMOC/front-end', '_self'), GITHUB);
mapkey(`${L}b`, 'Go to Backend repo', () => window.open('https://github.com/MyMOC/backend', '_self'), GITHUB);
mapkey(`${L}m`, 'Go to Mobile repo', () => window.open('https://github.com/MyMOC/mobilemoc', '_self'), GITHUB);

/* ───── admin.shopify.com ───── */
const SHOPIFY = {domain: /admin\.shopify\.com/};
mapkey(`${L}b`, 'Bookings', () => goShopify('https://admin.shopify.com/store/k3rgpa-ht/apps/izyrent/bookings'), SHOPIFY);
mapkey(`${L}nb`, 'New Booking', () => goShopify('https://admin.shopify.com/store/k3rgpa-ht/apps/izyrent/bookings'), SHOPIFY);
mapkey(`${L}c`, 'Customers', () => goShopify('https://admin.shopify.com/store/k3rgpa-ht/customers'), SHOPIFY);
mapkey(`${L}o`, 'Orders', () => goShopify('https://admin.shopify.com/store/k3rgpa-ht/orders'), SHOPIFY);
mapkey(`${L}d`, 'Draft Orders', () => goShopify('https://admin.shopify.com/store/k3rgpa-ht/draft_orders?selectedView=all'), SHOPIFY);
mapkey(`${L}no`, 'New Orders', () => goShopify('https://admin.shopify.com/store/k3rgpa-ht/orders?status=open'), SHOPIFY);
mapkey(`${L}i`, 'Izzy Rent', () => goShopify('https://admin.shopify.com/store/k3rgpa-ht/apps/izyrent'), SHOPIFY);

/* ───── youtube.com ───── */
if (/\.youtube\.com$/.test(location.hostname)) {
  const vid = () => document.querySelector('video');
  mapkey(`${L}p`, 'YT ▶/⏸ play-pause', () => { const v = vid(); if (v) v[v.paused ? 'play' : 'pause'](); });
  mapkey(`${L}+`, 'YT 🔊 volume +', () => { const v = vid(); if (v) v.volume = Math.min(1, v.volume + 0.05); });
  mapkey(`${L}-`, 'YT 🔉 volume –', () => { const v = vid(); if (v) v.volume = Math.max(0, v.volume - 0.05); });
  mapkey(`${L}f`, 'YT ⛶ full-screen', () => document.querySelector('.ytp-fullscreen-button')?.click());
}

/* ───── meet.google.com ───── */
if (/\.meet\.google\.com$/.test(location.hostname)) {
  const press = txt => document.querySelector(`[aria-label*="${txt}"]`)?.click();
  mapkey(`${L}n`, 'Meet 🎤 mic toggle',    () => press('microphone'));
  mapkey(`${L}v`, 'Meet 📷 camera toggle', () => press('camera'));
  mapkey(`${L}x`, 'Meet 🚪 leave call',    () => press('Leave call'));
}

// =============================================================================
// === Global Shortcuts (using Leader key) ===
// =============================================================================
mapkey(`${L}G`, '🐙 Go to GitHub', () => window.open('https://github.com', '_self'));
mapkey(`${L}I`, '🚀 Jump to Shortcut', () => window.open('https://app.shortcut.com/mymoc/iterations', '_self'));
mapkey(`${L}S`, '🛍 Shopify admin', () => window.open('https://admin.shopify.com/', '_self'));
// 
mapkey(`${L}W`, 'whatsapp', () => window.open('https://web.whatsapp.com/', '_self'));
mapkey(`ap`, 'Mocingbird Admin (Production)', () => window.open('https://admin.mocingbird.com/', '_self'));
mapkey(`ad`, 'Mocingbird Admin (Development)', () => window.open('http://d-admin.mocingbird.com:3000/', '_self'));
mapkey(`as`, 'Mocingbird Admin (Staging)', () => window.open('https://s-admin.mocingbird.com/', '_self'));

mapkey(`mp`, 'Mocingbird Admin (Production)', () => window.open('https://app.mocingbird.com/', '_self'));
mapkey(`md`, 'Mocingbird Admin (Development)', () => window.open('http://127.0.0.1.nip.io:4200/', '_self'));
mapkey(`ms`, 'Mocingbird Admin (Staging)', () => window.open('https://s-app.mocingbird.com//', '_self'));
