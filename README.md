This is setup for stow

## Mac

TODO:
add raycast config/keyboard shortcuts
add keyboard maestro setup
add synergy3 to .laptop

chrom/arc plugins

- add chrome vimuium plugin
- icloud password

## linux

## MacOS change keyboard shortcuts

Get bundle id

```bash
mdls -name kMDItemCFBundleIdentifier /Applications/Kitty.app
```

check existing keyboard shortcuts for an app with bundle id

```bash
defaults read net.kovidgoyal.kitty NSUserKeyEquivalents
```

set keyboard shortcut

```bash
defaults write net.kovidgoyal.kitty NSUserKeyEquivalents -dict-add "kitty Hide kitty" -string "@9"
```

delete existing keyboard shortcut

```bash
defaults delete net.kovidgoyal.kitty NSUserKeyEquivalents
```

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

TODO:

- setup fix for keyboard (ie autohotkey)
- setup dotfiles for windows - neovim - alacritty
  Applications
- icue
- autohotkey
- komorebi
