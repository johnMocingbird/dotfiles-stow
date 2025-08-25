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
- **Toggle Disabled Mode**  
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
- <kbd>f</kbd> → Toggle zoom-parent
- <kbd>s</kbd> → Toggle split
- <kbd>e</kbd> (shared with `resize`) → Balance space

#### Additional

- <kbd>x</kbd> → Run AppleScript (close tab in some apps)
  
---

### Application Launcher Mode

todo.

---

### Resize Mode

> **How to Enter**: <kbd> r</kbd> (from window_management)  

- <kbd>h</kbd> → Resize window horizontally (-100)  
- <kbd>j</kbd> → Resize window vertically (+100)  
- <kbd>k</kbd> → Resize window vertically (-100)  
- <kbd>l</kbd> → Resize window horizontally (+100)  
- <kbd>c</kbd> (shared w/ `window_management`) → Big horizontal resize (±700)

#### Shared Focus with Default/Move

- <kbd>lalt + h</kbd> → Focus west  
- <kbd>lalt + j</kbd> → Focus south  
- <kbd>lalt + k</kbd> → Focus north  
- <kbd>lalt + l</kbd> → Focus east

#### Balance Space

- <kbd>e</kbd> → `yabai -m space --balance`

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
  - <kbd>lalt + w</kbd> → Open Arc
  - <kbd>lalt + i</kbd> → Open Simulator
  - <kbd>lalt + x</kbd> → Open Xcode
  - <kbd>lalt + c</kbd> → Open ChatGPT
  - <kbd>lalt + s</kbd> → Open Slack
  - <kbd>shift + lalt + s</kbd> → Open “Mocingbird: Shortcut.app”
  - <kbd>lalt + return</kbd> → Open Alacritty
  - <kbd>lalt + t</kbd> → Open kitty
  - <kbd>shift + lalt + t</kbd> → Open a new kitty instance
  - <kbd>lalt + n</kbd> → Open Numbers
  - <kbd>lalt + p</kbd> → Open Passwords

  - <kbd>lalt + y</kbd> → Launch `fzfyabi.sh` in kitty (Window switcher)

- **Scratchpad toggles**  
  - <kbd>rctrl + a</kbd> → Toggle Music window
  - <kbd>rctrl + t</kbd> → Toggle Alacritty window
  - <kbd>rctrl + h</kbd> → Toggle Home app
  - <kbd>rctrl + p</kbd> → Toggle iPhone Mirroring
  - <kbd>rctrl + w</kbd> → Toggle Safari
  - <kbd>rctrl + i</kbd> → Toggle Simulator
  - <kbd>rctrl + s</kbd> → Toggle Slack
  - <kbd>rctrl + m</kbd> → Toggle Messages
  - <kbd>rctrl + d</kbd> → Toggle Stream Deck
  - <kbd>rctrl + shift + s</kbd> → Toggle Shortcut
  - <kbd>rctrl + c</kbd> → Toggle ChatGPT

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
  - <kbd>alt + ctrl + shift + ←/→/↑/↓</kbd> → Move floating window
  - <kbd>alt + shift + z</kbd> → `float_center.sh`

- **Fullscreen / Zoom**  
  - <kbd>cmd + ctrl + f</kbd> → Toggle zoom-fullscreen
  - <kbd>lalt + z</kbd> → Toggle zoom-parent
  - <kbd>shift + lalt + x</kbd> → Mirror space on X-axis
  - <kbd>shift + lalt + y</kbd> → Mirror space on Y-axis

- **Stacking**  
  - <kbd>shift + ctrl + h/j/k/l</kbd> → Stack window west/south/north/east
  - <kbd>shift + ctrl + n</kbd> → Focus stack.next
  - <kbd>shift + ctrl + p</kbd> → Focus stack.prev

- **Resizing**  
  - <kbd>ctrl + lalt + h/j/k/l</kbd> → Resize active window
  - <kbd>ctrl + lalt + e</kbd> → Balance space
  - <kbd>ctrl + lalt + g</kbd> → Toggle space padding & gap
  - <kbd>ctrl + lalt + b</kbd> → Disable border
  - <kbd>shift + ctrl + lalt + b</kbd> → Enable border

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

- <kbd>Prefix + o</kbd>  
  Open `sessionx` a popup to switch sessions

---

### Popups & Commands

- <kbd>Prefix + f</kbd>  
  Open `nnn -d` in a popup (file explorer)
- <kbd>Prefix + n</kbd>  
  Run `popuptmux-notes` (Obsidian notes)
- <kbd>Prefix + z</kbd>  
  Open `fzf-sessions` in a popup
- <kbd>Prefix + G</kbd>  
  Run `,tmux-popup lazygit`
- <kbd>Prefix + m</kbd>  
  Run `popuptmux weechat`
- <kbd>Prefix + b</kbd>  
  Run `popuptmux w3m www.google.com`
- <kbd>Prefix + t</kbd>  
  Run `popuptmux dooit`
- <kbd>Prefix + a</kbd>  
  Run `popuptmux gemini`

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
- <kbd>Prefix + q</kbd> → Go to window named `side_kiq`

---

### Additional

- <kbd>Ctrl+\\</kbd> → Sends `Ctrl+\\` to the pane  
- <kbd>Prefix + b</kbd> → Toggle status line  

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
