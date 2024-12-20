This is setup for stow

```bash
git clone git@github.com:MyMOC/front-end.git
git clone git@github.com:MyMOC/mymoc.git
git clone git@github.comjohnMocingbird/mydots-stow.git

cd Desktop/Parallels\ Shared\ Folders/iCloud/
cp latest.dump ~/mymoc/docker/
cp env.development.local ~/mymoc/.env.development.local
```

cd mymoc/docker

TODO:

add better display to .laptop
add raycast config/keyboard shortcuts
add keyboard maestro setup
add meetingbar to .laptop
add homerow to .laptop
add synergy3 to .laptop
add script for ssh keysetup, git and ubuntu

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
