
alias ios='cd ~/development/mobile_dev/mobilemoc-ios/ && npx react-native run-ios --terminal Terminal --simulator="iPhone 15 Pro Max" --scheme="Staging" --mode Debug'
alias ios_local='cd ~/development/mobile_dev/mobilemoc-ios/ && npx react-native run-ios --terminal Terminal --simulator="iPhone 15 Pro Max" --scheme="Development" --mode Debug'
alias mobile='cd ~/development/mobile_dev/mobilemoc-ios/'
alias ubuntu='ssh -i /Users/john/.ssh/ubuntu_id_rsa john@192.168.50.75'
alias ubuntu_server='ssh -L 3000:localhost:3000 -i /Users/john/.ssh/ubuntu_id_rsa john@192.168.50.75'

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


alias mymoc='tmuxinator start mymoc'
alias r_c='tmuxinator start rails_console'
alias front='tmuxinator start front_end'

