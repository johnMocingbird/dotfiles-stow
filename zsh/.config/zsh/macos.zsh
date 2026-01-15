
alias ios='cd ~/development/mobilemoc/ && npx react-native run-ios --simulator="iPhone 16 Pro" --scheme="Staging" --mode Debug'
alias ios_local='cd ~/development/mobilemoc/ && npx react-native run-ios --terminal iTerm --simulator="iPhone 15 Pro Max" --scheme="Development" --mode Debug'
alias mobile='cd ~/development/mobilemoc/'
alias ubuntu='ssh -i /Users/john/.ssh/ubuntu_id_rsa john@192.168.1.21'
alias ubuntu_server='ssh -L 3000:localhost:3000 -i /Users/john/.ssh/ubuntu_id_rsa john@192.168.1.21'

clean_ios() {


  cd ~/development/mobile_dev/mobilemoc-ios/
  rm -fr node_modules package-lock.json
  npm cache clean --force
  npm i --force

  cd ~/development/mobile_dev/mobilemoc-ios/ios/
  rm -rf ~/Library/Caches/CocoaPods
  rm -rf Pods
  rm -f Podfile.lock
  rm -rf ~/Library/Developer/Xcode/DerivedData/*
  xcodebuild clean
  pod cache clean --all
  pod deintegrate
  pod setup && pod install --verbose
  cd ..
  npx react-native start --reset-cache
}

export NNN_PLUG='l:launch;y:cbcopy-mac;p:cbpaste-mac;v:preview-tui;i:imgview;a:apk-staging;A:apk-prod'


# NOTE: Tmuxinator
alias mymoc='tmuxinator start mymoc'
alias r_c='tmuxinator start rails_console'
alias front='tmuxinator start front_end'
alias notes='tmuxinator start obsidian'

### sketchybar
function zen () {
  ~/.config/sketchybar/plugins/zen.sh $1
}


### yabai
function suyabai () {
  SHA256=$(shasum -a 256 /opt/homebrew/bin/yabai | awk "{print \$1;}")
  if [ -f "/private/etc/sudoers.d/yabai" ]; then
    sudo sed -i '' -e 's/sha256:[[:alnum:]]*/sha256:'${SHA256}'/' /private/etc/sudoers.d/yabai
  else
    echo "sudoers file does not exist yet"
  fi
}


function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

