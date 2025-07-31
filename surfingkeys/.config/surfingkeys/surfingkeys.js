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

// ---- Settings ----
Hints.setCharacters('asdfgyuiopqwertnmzxcvb');

settings.defaultSearchEngine = 'd';
settings.hintAlign = 'left';
settings.omnibarPosition = 'bottom';
settings.focusFirstCandidate = false;
settings.focusAfterClosed = 'last';
settings.scrollStepSize = 200;
settings.tabsThreshold = 0;
settings.modeAfterYank = 'Normal';

/* theme: centre popup + bigger keys */
settings.theme = `
#sk_keystroke{
  left:50%!important; bottom:50%!important;
  transform:translate(-50%,50%);
  font-size:22px !important;
  padding:12px 16px;
}
#sk_keystroke kbd{ font-size:24px !important; }
`;
settings.richHintsForKeystroke = 500;   // keep the popup, just restyled

// ---- Map -----
// --- Hints ---
// Open Multiple Links
map('<Alt-f>', 'cf');
function regionHints(side) {
  const W = window.innerWidth, H = window.innerHeight;
  const test = r => ({
    left:  r.right  < W/2,
    right: r.left   > W/2,
    bottom:r.top    > H/2
  }[side]);
  const els = [...document.querySelectorAll('a,button,[onclick],input[type=submit]')]
               .filter(e => {
                 const r = e.getBoundingClientRect();
                 return r.width && r.height && test(r);
               });
  Hints.create(els, Hints.dispatchMouseClick);
}
mapkey('<Space>hl', 'Hints on left half' , () => regionHints('left'));
mapkey('<Space>hr', 'Hints on right half', () => regionHints('right'));
mapkey('<Space>hb', 'Hints on bottom'    , () => regionHints('bottom'));

// Yank Link URL
map('<Alt-y>', 'ya');
map('<Alt-u>', 'ya');

// Open Hint in new tab
map('F', 'C');

// --- Nav ---
// Open Clipboard URL in current tab
mapkey('p', "Open the clipboard's URL in the current tab", () => { Clipboard.read(function(response) { window.location.href = response.data; }); });

// Open Clipboard URL in new tab
map('P', 'cc');

// Open a URL in current tab
map('o', 'go');

// Choose a buffer/tab
map('b', 'T');

// Edit current URL, and open in same tab
map('O', ';U');

// Edit current URL, and open in new tab
map('T', ';u');
// History Back/Forward
map('H', 'S');
/* --- put these three lines together, in this order --- */
unmap('R');          // drop old history-forward override
map('R', 'L');       // ✔  R now inherits the *default* regional-hints
unmap('L');          // drop old history-forward override


// Scroll Page Down/Up
mapkey("<Ctrl-d>", "Scroll down", () => { Normal.scroll("pageDown"); });
mapkey("<Ctrl-u>", "Scroll up", () => { Normal.scroll("pageUp"); });
map('<Ctrl-b>', 'U');  // scroll full page up

// Next/Prev Page
map('K', '[[');
map('J', ']]');

// Open Chrome Flags
mapkey('gF', '#12Open Chrome Flags', () => { tabOpenLink("chrome://flags/"); });

// --- Tabs ---
// Tab Delete/Undo
map('D', 'x');
mapkey('d', '#3Close current tab', () => { RUNTIME("closeTab"); });
mapkey('u', '#3Restore closed tab', () => { RUNTIME("openLast"); });

// Move Tab Left/Right w/ one press
map('>', '>>');
map('<', '<<');

// Tab Next/Prev
// map('<Alt-j>', 'R');
map('<Alt-k>', 'E');

// --- Misc ---
// Yank URL w/ one press (disables other yx binds)
map('y', 'yy');

// Change focused frame
map('gf', 'w');

// ---- Unmap -----
// Proxy Stuff
unmap('spa');
unmap('spb');
unmap('spc');
unmap('spd');
unmap('sps');
unmap('cp');
unmap(';cp');
unmap(';ap');
unmap('gs')

// Emoji
iunmap(":");

// Misc
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
unmap('e')

// ---- Search Engines -----
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

/** ---------- scroll tweaks ---------- */
unmap('^');
mapkey('^', '#scroll-leftmost', 'Normal.scroll("leftmost")', {repeatIgnore: true});
mapkey('$', '#scroll-rightmost', 'Normal.scroll("rightmost")', {repeatIgnore: true});
/* ---- Scroll with U / D ---- */
unmap('u');                                 // frees the key – you still have d for close tab
unmap('d');
mapkey('d', 'Scroll page down', () => Normal.scroll("pageDown"));
mapkey('u', 'Scroll page up',   () => Normal.scroll("pageUp"));

/* ---- “ge”-style edit URL ---- */
unmap('ge');          // drop default “Go Extension” shortcut
map('ge', ';U');

/* ───── conditional T / t mappings (Safari vs others) ───── */
const isSafari = /Safari/.test(navigator.userAgent) &&
                 !/Chrome|Chromium|Edg/i.test(navigator.userAgent);

if (isSafari) {
    // Safari → keep built-in “T” (SurfingKeys default), only change `t`
    unmap('t');
    mapkey('t', 'New tab → DuckDuckGo',
           () => open('https://duckduckgo.com'));
} else {
    // Other browsers → `T` = tab-picker, `t` = DuckDuckGo
    unmap('t'); unmap('T');
    mapkey('T', 'Choose a tab (fuzzy finder)',
           () => Front.openOmnibar({ type: 'Tabs' }));
    mapkey('t', 'New tab → DuckDuckGo',
           () => open('https://duckduckgo.com'));
}

mapkey('<Space>gpm', 'Jump to GitHub repo', () => {
    open('https://github.com/MyMOC/mymoc/pulls');          // change URL as needed
});


// s-admin
mapkey('gsu', 's-admin users', () => open('https://s-admin.mocingbird.com/admin/users'));
mapkey('gsl', 's-admin licenses', () => open('https://s-admin.mocingbird.com/admin/state_licenses'));
mapkey('gsr', 's-admin roles', () => open('https://s-admin.mocingbird.com/admin/roles'));
mapkey('gso', 's-admin orgs',  () => open('https://s-admin.mocingbird.com/admin/organizations'));

// main
mapkey('gmu', 'main users',   () => open('https://admin.mocingbird.com/admin/users'));
mapkey('gml', 'main licenses',() => open('https://admin.mocingbird.com/admin/state_licenses'));
mapkey('gmr', 'main roles',   () => open('https://admin.mocingbird.com/admin/roles'));
mapkey('gmo', 'main orgs',    () => open('https://admin.mocingbird.com/admin/organizations'));

// local dev
mapkey('glu', 'dev users',    () => open('http://d-admin.mocingbird.com:3000/admin/users'));
mapkey('gll', 'dev licenses', () => open('http://d-admin.mocingbird.com:3000/admin/state_licenses'));
mapkey('glr', 'dev roles',    () => open('http://d-admin.mocingbird.com:3000/admin/roles'));
mapkey('glo', 'dev orgs',     () => open('http://d-admin.mocingbird.com:3000/admin/organizations'));

// --- leader key (space) ---
const L = '<Space>';

// 1) Global: jump to GitHub home
mapkey(`${L}G`, 'Go to GitHub', () => window.open('https://github.com', '_blank'));

// 2) GitHub-only helpers for the current repo
function repoRoot() {
  const m = location.href.match(/^https:\/\/github\.com\/[^\/]+\/[^\/]+/);
  return m ? m[0] : null;
}
function openSection(section = '') {
  const base = repoRoot();
  if (base) window.open(`${base}${section && '/' + section}`, '_self');
}

mapkey(`${L}c`, 'Code tab',      () => openSection(),            {domain: /github\.com/});
mapkey(`${L}p`, 'Pull requests', () => openSection('pulls'),     {domain: /github\.com/});
mapkey(`${L}w`, 'Wiki',          () => openSection('wiki'),      {domain: /github\.com/});
mapkey(`${L}s`, 'Stars',         () => openSection('stargazers'),{domain: /github\.com/});

/* ----------  Shopify ---------- */
// Global: jump to Shopify admin root
mapkey(`${L}S`, 'Shopify admin', () =>
  window.open('https://admin.shopify.com/', '_blank'));

// Helper for shop-specific links (fill in the real paths)
function goShopify(path) {
  window.open(path, '_self');        // path like 'https://admin.shopify.com/store/your-shop/…'
}

// Shopify-only shortcuts
const SHOPIFY = {domain: /admin\.shopify\.com/};

// mapkey(`${L}R`, 'Rental pages', () => goShopify('RENTAL_URL'),       SHOPIFY);
// mapkey(`${L}I`, 'Izzy Rent',    () => goShopify('IZZY_RENT_URL'),    SHOPIFY);
mapkey(`${L}B`, 'Bookings',     () => goShopify('https://admin.shopify.com/store/k3rgpa-ht/apps/izyrent/bookings'),     SHOPIFY);
// mapkey(`${L}P`, 'Products',     () => goShopify('PRODUCTS_URL'),     SHOPIFY);
// mapkey(`${L}C`, 'Customers',    () => goShopify('CUSTOMERS_URL'),    SHOPIFY);


/* ----------  Shortcut Git-Helpers copy v3  ---------- */
const SHORTCUT = { url: /https:\/\/app\.shortcut\.com\/mymoc\/story\// };

const OPENER  = 'button[data-on-click="openGitHelpers"]';
const POPUP   = '#git-branch-dialog, .git-branch-dialog';
const FIELD_BRANCH  = '.git-branch';           // the readonly <input> or <code>
const FIELD_CMD     = '.git-branch-command';   // same for checkout cmd

/* wait for element helper */
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

/* open popup if needed, then copy text inside target field */
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

/* ␣B → copy branch name */
mapkey(`${L}B`, 'Copy branch name',
       () => copyText(FIELD_BRANCH,  'Branch name copied!'), SHORTCUT);

/* ␣C → copy checkout command */
mapkey(`${L}C`, 'Copy checkout cmd',
       () => copyText(FIELD_CMD,     'Checkout cmd copied!'), SHORTCUT);


settings.theme += `
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
`;

settings.theme += `
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
