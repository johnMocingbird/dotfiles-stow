This is setup for stow

## Mac Keybindings

1. [Leader Mode](#leader-mode)
2. [Window Management Mode](#window-management-mode)
3. [Application Launcher Mode](#application-launcher-mode)
4. [Resize Mode](#resize-mode)
5. [System Settings Mode](#system-settings-mode)
6. [Disabled Mode](#disabled-mode)
7. <D-f>

---

### Leader Mode
>
> **How to Enter**: From Default with <kbd>lalt + space</kbd>.  

#### Leader → Other Modes or Actions

- <kbd>p</kbd> → `system_settings`
- <kbd>w</kbd> → `window_management`
- <kbd>x</kbd> → `disabled`
- <kbd>space</kbd> → Open Kitty terminal (then return to default)
- **Toggle Disabled Mode (global)**
  - <kbd>cmd + alt + ctrl + shift + d</kbd> → `disabled`
  - Then <kbd>cmd + alt + ctrl + shift + e</kbd> → back to `default`

- <kbd>h</kbd> → Focus west
- <kbd>j</kbd> → Focus south
- <kbd>k</kbd> → Focus north
- <kbd>l</kbd> → Focus east

- <kbd>1</kbd> → Focus space #1
- <kbd>2</kbd> → Focus space #2
- <kbd>3</kbd> → Focus space #3
- <kbd>4</kbd> → Focus space #4

---

## Window Management Mode

> **How to Enter**: From Leader with <kbd> w</kbd>

#### Focus / Navigation

- <kbd>h</kbd> → Focus west  
- <kbd>j</kbd> → Focus south  
- <kbd>k</kbd> → Focus north  
- <kbd>l</kbd> → Focus east  
- <kbd>n</kbd> → Focus next stack window  
- <kbd>p</kbd> → Focus previous stack window  
- <kbd>y</kbd> → Focus first window  
- <kbd>o</kbd> → Focus last window

#### Space Switching

- <kbd>1</kbd> → Focus space #1  
- <kbd>2</kbd> → Focus space #2  
- <kbd>3</kbd> → Focus space #3  
- <kbd>4</kbd> → Focus space #4

#### Window Actions

- <kbd>space</kbd> → Toggle float
- <kbd>g</kbd> → Toggle zoom-fullscreen
- <kbd>z</kbd> → Toggle zoom-parent
- <kbd>s</kbd> → Toggle split
- <kbd>e</kbd> (shared with `resize`) → Balance space

#### Floating Window Movement (Window Management Mode)

- <kbd>←</kbd> → Move floating window left 50px
- <kbd>→</kbd> → Move floating window right 50px
- <kbd>↑</kbd> → Move floating window up 50px
- <kbd>↓</kbd> → Move floating window down 50px

#### Additional

- <kbd>x</kbd> → Close window (Cmd+W via AppleScript)
  
---

### Application Launcher Mode

todo.

---

### Resize Mode

> **How to Enter**: <kbd>Cmd + Alt + Ctrl + r</kbd> (global) or <kbd>r</kbd> (from window_management)

- <kbd>h</kbd> → Resize window horizontally (-100)
- <kbd>j</kbd> → Resize window vertically (+100)
- <kbd>k</kbd> → Resize window vertically (-100)
- <kbd>l</kbd> → Resize window horizontally (+100)
- <kbd>c</kbd> (shared w/ `window_management`) → Big horizontal resize (±700)
- <kbd>e</kbd> → Balance space

#### Floating Window Movement (Resize Mode)

- <kbd>←</kbd> → Move floating window left 50px
- <kbd>→</kbd> → Move floating window right 50px
- <kbd>↑</kbd> → Move floating window up 50px
- <kbd>↓</kbd> → Move floating window down 50px

#### Shared Focus with Default

- <kbd>lalt + h</kbd> → Focus west
- <kbd>lalt + j</kbd> → Focus south
- <kbd>lalt + k</kbd> → Focus north
- <kbd>lalt + l</kbd> → Focus east

---

### System Settings Mode

> **How to Enter**:  
>
> - From Leader with <kbd>p</kbd>

- <kbd>b</kbd> → Open Bluetooth manager (via Raycast)  
- <kbd>w</kbd> → Scan Wi-Fi networks (via Raycast)  
- <kbd>o</kbd> → Set output audio device (Raycast)  
- <kbd>i</kbd> → Set input audio device (Raycast)  
- <kbd>d</kbd> → Toggle desktop icons (Raycast)  
- <kbd>h</kbd> → Toggle hidden files (Raycast)  
- <kbd>r</kbd> → Apply `monitor-layout--obs--overhead` (Raycast)  
- <kbd>m</kbd> → Apply `monitor-layout-main` (Raycast)  
- <kbd>t</kbd> → Open Trash (Raycast)  
- <kbd>p</kbd> → Connect to AirPods (custom keystroke)
- <kbd>s</kbd> → Toggle Mac Settings (scratch pad)

---

### Global Bindings (in Default Mode)

- **Open / Launch various apps (while in Default)**

  - <kbd>shift + lalt + w</kbd> → Open Safari
  - <kbd>lalt + w</kbd> → Open Google Chrome
  - <kbd>lalt + i</kbd> → Open Simulator
  - <kbd>lalt + x</kbd> → Open Xcode
  - <kbd>lalt + c</kbd> → Open ChatGPT
  - <kbd>lalt + o</kbd> → Open OBS
  - <kbd>lalt + s</kbd> → Open Slack
  - <kbd>shift + lalt + s</kbd> → Open "Mocingbird: Shortcut.app"
  - <kbd>shift + lalt + m</kbd> → Open Google Meet
  - <kbd>lalt + return</kbd> → Open Alacritty
  - <kbd>lalt + t</kbd> → Open kitty
  - <kbd>shift + lalt + t</kbd> → Open a new kitty instance
  - <kbd>lalt + n</kbd> → Open Numbers
  - <kbd>alt + p</kbd> → Toggle Passwords (scratchpad)

  - <kbd>lalt + y</kbd> → Launch `fzfyabi.sh` in kitty (Window switcher)

- **Scratchpad toggles (RCtrl or Fn keys)**
  - <kbd>rctrl + f</kbd> / <kbd>fn + f</kbd> → Toggle Firefox
  - <kbd>rctrl + a</kbd> / <kbd>fn + a</kbd> → Toggle Music window
  - <kbd>rctrl + t</kbd> / <kbd>fn + t</kbd> → Toggle Alacritty window
  - <kbd>rctrl + h</kbd> / <kbd>fn + h</kbd> → Toggle Home app
  - <kbd>rctrl + shift + p</kbd> / <kbd>fn + shift + p</kbd> → Toggle iPhone Mirroring
  - <kbd>rctrl + w</kbd> / <kbd>fn + w</kbd> → Toggle Safari
  - <kbd>rctrl + p</kbd> / <kbd>fn + p</kbd> → Toggle Postman
  - <kbd>rctrl + i</kbd> / <kbd>fn + i</kbd> → Toggle Simulator
  - <kbd>rctrl + s</kbd> / <kbd>fn + s</kbd> → Toggle Slack
  - <kbd>rctrl + m</kbd> / <kbd>fn + m</kbd> → Toggle Messages
  - <kbd>rctrl + d</kbd> / <kbd>fn + d</kbd> → Toggle Stream Deck
  - <kbd>rctrl + shift + s</kbd> / <kbd>fn + shift + s</kbd> → Toggle Shortcut
  - <kbd>rctrl + v</kbd> / <kbd>fn + v</kbd> → Toggle WhatsApp
  - <kbd>rctrl + shift + v</kbd> → Vim anywhere script
  - <kbd>rctrl + shift + c</kbd> / <kbd>fn + shift + c</kbd> → Toggle ChatGPT (Chrome)
  - <kbd>rctrl + c</kbd> / <kbd>fn + c</kbd> → Toggle ChatGPT

- **macOS App Scratchpad toggles (RCmd)**
  - <kbd>rcmd + p</kbd> → Toggle Photos
  - <kbd>rcmd + m</kbd> → Toggle Mail
  - <kbd>rcmd + n</kbd> → Toggle Numbers
  - <kbd>rcmd + c</kbd> → Toggle Calendar
  - <kbd>rcmd + w</kbd> → Toggle Weather
  - <kbd>rcmd + s</kbd> → Toggle Siri

- **Space Navigation (Default)**  
  - <kbd>lalt + 1</kbd> → Focus space #1  
  - <kbd>lalt + 2</kbd> → Focus space #2  
  - <kbd>lalt + 3</kbd> → Focus space #3  
  - <kbd>lalt + 4</kbd> → Focus space #4  
  - <kbd>lalt + [</kbd> (0x21) → Focus previous space  
  - <kbd>lalt + ]</kbd> (0x1E) → Focus next space
  - <kbd>shift + lalt + p</kbd> → Move window to previous space & focus  
  - <kbd>shift + lalt + n</kbd> → Move window to next space & focus

- **Floating Window Movement**
  - <kbd>alt + shift + z</kbd> → Float window center (`float_center.sh`)

- **Fullscreen / Zoom**
  - <kbd>cmd + ctrl + f</kbd> → Toggle zoom-fullscreen
  - <kbd>lalt + z</kbd> → Toggle zoom-parent

- **Stacking**
  - <kbd>shift + ctrl + h/j/k/l</kbd> → Stack window west/south/north/east
  - <kbd>shift + ctrl + n</kbd> → Focus stack.next
  - <kbd>shift + ctrl + p</kbd> → Focus stack.prev

- **Insertion**  
  - <kbd>shift + ctrl + lalt + h/j/k/l/s</kbd> → Insert window west/south/north/east/stack
  - <kbd>lalt + v</kbd> → Insert window south + `cmd - n`

## TMUX Keybindings

**Prefix**  

- <kbd>Ctrl+s</kbd>

---

Reload Configuration

- <kbd>Prefix + r</kbd>
  Reload `~/.tmux.conf`

- <kbd>F12</kbd> (no prefix)
  Open `sessionx` a popup to switch sessions

---

### Popups & Commands

- <kbd>Prefix + f</kbd>
  Open `nnn -d` in a popup (file explorer)
- <kbd>Prefix + n</kbd>
  Run `popuptmux-notes` (Obsidian notes)
- <kbd>Prefix + z</kbd>
  Open `fzf-sessions` in a popup
- <kbd>Prefix + w</kbd>
  Open `fzf-windows` in a popup (window switcher)
- <kbd>Prefix + G</kbd>
  Run `popuptmux lazygit`
- <kbd>Prefix + m</kbd>
  Run `popuptmux weechat`
- <kbd>Prefix + d</kbd>
  Run `popuptmux specs` (run specs)
- <kbd>Prefix + B</kbd>
  Run `popuptmux w3m www.google.com` (web browser)
- <kbd>Prefix + t</kbd>
  Run `popuptmux dooit` (task manager)
- <kbd>Prefix + a</kbd>
  Run `popuptmux gemini` (Gemini CLI)
- <kbd>Prefix + v</kbd>
  Voice to text popup
- <kbd>Prefix + P</kbd>
  AI CLI preview (shows ai_cli pane output)
- <kbd>Ctrl + a</kbd> (no prefix)
  Toggle AI split

---

### Pane Navigation (Vi-Style)

- <kbd>Prefix + h</kbd> → Select pane left  
- <kbd>Prefix + j</kbd> → Select pane down  
- <kbd>Prefix + k</kbd> → Select pane up  
- <kbd>Prefix + l</kbd> → Select pane right  

*Note:* `setw -g mode-keys vi` sets copy-mode to Vi-keys.

---

### Window Switching

- <kbd>Prefix + e</kbd> → Go to window named `neovim`
- <kbd>Prefix + s</kbd> → Go to window named `server`
- <kbd>Prefix + c</kbd> → Go to window named `rails_console`
- <kbd>Prefix + g</kbd> → Go to window named `lazy_git`
- <kbd>Prefix + A</kbd> → Go to window named `ai_cli`
- <kbd>Prefix + q</kbd> → Go to window named `side_kiq`

---

### Additional

- <kbd>Ctrl+\\</kbd> → Sends `Ctrl+\\` to the pane
- <kbd>Prefix + b</kbd> → Toggle status line

---

## Kitty Keybindings

**Modifier Key**: `Ctrl+Shift` (kitty_mod)

### Tab Management

- <kbd>Cmd + 1-9</kbd> → Go to tab 1-9

### Clipboard

- <kbd>Ctrl + Shift + c</kbd> → Copy to clipboard
- <kbd>Ctrl + Shift + v</kbd> → Paste from clipboard

### Launching Tools & Popups

- <kbd>Cmd + t</kbd> → New tab (current directory)
- <kbd>Cmd + n</kbd> → New OS window (current directory)
- <kbd>kitty_mod + a</kbd> → Launch tmux attach
- <kbd>Cmd + b</kbd> → Launch btop
- <kbd>Cmd + Alt + b</kbd> → Launch voice input
- <kbd>Cmd + d</kbd> → Launch dooit (task manager)
- <kbd>Cmd + g</kbd> → Launch lazygit
- <kbd>Cmd + s</kbd> → Launch fzf-sessions (tmux session switcher)
- <kbd>Cmd + c</kbd> → Launch config directory picker with fzf
- <kbd>Cmd + f</kbd> → Launch nnn (file browser, horizontal split)

### Scrollback & History

- <kbd>Cmd + v</kbd> → Browse scrollback buffer in nvim
- <kbd>kitty_mod + g</kbd> → Browse last shell command output in nvim
- <kbd>Cmd + 0</kbd> → Kitty grab (hints mode)

### Window Management

- <kbd>Ctrl + Shift + /</kbd> → Split window horizontally
- <kbd>F4</kbd> → Launch split

### Special Commands

- <kbd>Ctrl + Alt + Cmd + e</kbd> → Send `nvim .` to all panes
- <kbd>Ctrl + Shift + m</kbd> → Copy script (OBS video shortcuts)

---

## SurfingKeys (Browser Vim Keybindings)

**Leader Key**: `Space`

### Global Shortcuts

- `t` → Open dashboard (https://esthing64.github.io/my_dashboard/)
- `T` → Choose a tab (fuzzy finder) - *Not available in Safari*

### Navigation & Scrolling

- `H` → History Back
- `L` → History Forward
- `K` → Next Page
- `J` → Previous Page
- `d` → Scroll page down
- `u` → Scroll page up
- `Ctrl+d` → Scroll down
- `Ctrl+u` → Scroll up
- `Ctrl+b` → Scroll full page up
- `^` → Scroll leftmost

### Hints & Links

- `F` → Open Hint in new tab
- `Alt+f` → Open Multiple Links
- `Alt+y` / `Alt+u` → Yank Link URL

### URL & OmniBar

- `o` → Open a URL in current tab
- `O` / `ge` → Edit current URL in same tab
- `T` → Edit current URL in new tab
- `p` → Open clipboard URL in current tab
- `P` → Open clipboard URL in new tab

### Tabs

- `b` → Choose a buffer/tab
- `D` → Close current tab
- `>` → Move Tab Right
- `<` → Move Tab Left
- `Alt+k` → Tab Next (Alt+j for Prev)

### Misc

- `y` → Yank URL
- `gf` → Change focused frame
- `gF` → Open Chrome Flags

### Site-Specific: GitHub.com

**Leader + ...**
- `c` → Code tab
- `p` → Pull requests
- `w` → Wiki
- `s` → Stars
- `f` → Go to Front-end repo
- `b` → Go to Backend repo
- `m` → Go to Mobile repo

### Site-Specific: Shortcut.com (MyMoc stories)

**Leader + ...**
- `B` → Copy branch name
- `C` → Copy checkout command

### Site-Specific: Mocingbird Admin (admin.mocingbird.com)

**Leader + ...**
- `u` → Admin → Users
- `l` → Admin → Licenses
- `r` → Admin → Roles
- `o` → Admin → Organizations
- `f` → Admin → Filter User (only on /admin/users page)

### Site-Specific: Mocingbird App (app.mocingbird.com)

**Leader + ...**
- `s` → Toggle SuperAdmin mode

### Site-Specific: Shopify Admin

**Leader + ...**
- `b` → Bookings
- `nb` → New Booking
- `c` → Customers
- `o` → Orders
- `d` → Draft Orders
- `no` → New Orders
- `i` → Izzy Rent

### Site-Specific: YouTube

**Leader + ...**
- `p` → Play/Pause
- `+` → Volume up
- `-` → Volume down
- `f` → Full screen

### Site-Specific: Google Meet

**Leader + ...**
- `n` → Toggle microphone
- `v` → Toggle camera
- `x` → Leave call

### Global Navigation Shortcuts

**Leader + ...**
- `G` → Go to GitHub
- `I` → Jump to Shortcut (Iterations)
- `M` → Gmail Inbox
- `S` → Shopify admin
- `W` → WhatsApp Web

### Quick Access to Mocingbird Environments

**Admin:**
- `ap` → Admin Production (admin.mocingbird.com)
- `as` → Admin Staging (s-admin.mocingbird.com)
- `ad` → Admin Development (d-admin.mocingbird.com:3000)

**App:**
- `mp` → App Production (app.mocingbird.com)
- `ms` → App Staging (s-app.mocingbird.com)
- `md` → App Development (127.0.0.1.nip.io:4200)

---

## linux

## MacOS change keyboard shortcuts

todo:
Android Studio.app
File-Invalidate Caches...
AT\*Z
Build-Generate Signed Bundle / APK...
^ 我D
File->Sync Project with Gradle Files
^ 我S

## Windows

- <https://github.com/LGUG2Z/komorebi>
- <https://github.com/ChrisTitusTech/winutil>

mklink /D "C:\Users\coakl\.config\alacritty" "C:\Users\coakl\AppData\Roaming\alacritty"  
mklink /D C:\Users\coakl\.config\nvim C:\Users\coakl\AppData\Local\nvim

TODO:

- setup fix for keyboard (ie autohotkey)
- setup dotfiles for windows - neovim - alacritty
  Applications
- icue
- autohotkey
- komorebi

### Projects

```sh
 git clone git@github.com:MyMOC/mymoc.git $HOME/mymoc
 git clone git@github.com:MyMOC/mobilemoc.git $HOME/development/mobilemoc
 git clone git@github.com:MyMOC/front-end.git $HOME/development/front-end
 git clone git@github.com:MyMOC/utilities.git $HOME/development/utilities_mymoc
 git clone git@github.com:rails/rails.git $HOME/development/docs/rails_api
 git clone git@github.com:ruby/ruby.git $HOME/development/docs/ruby
```

### Setup Local docs

```sh
gem install rdoc-markdown
```

```sh
rdoc --format=markdown
```
