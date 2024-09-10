if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
export PATH="$HOME/bin:/usr/local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

[ -d "/opt/homebrew/share/zsh-autosuggestions/" ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
                                                  || source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -d "/opt/homebrew/share/zsh-syntax-highlighting/highlighters" ] && export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters \
                                                                  || export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

[ -d "/opt/homebrew/share/zsh-syntax-highlighting/" ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
                                                  || source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster")
# ZSH_THEME="dracula-pro"
CASE_SENSITIVE="true"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode disabled

zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"

DISABLE_LS_COLORS="true"

DISABLE_AUTO_TITLE="true"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy"

plugins=(gh git rails tmux iterm2 zsh-autosuggestions web-search)
source $ZSH/oh-my-zsh.sh

alias start_worker="redis-cli flushall && bundle exec sidekiq"
alias start_backend="bin/rails s"
alias f="~/./dir_menu.sh"

# Aliases for common dirs
alias home="cd ~"

# System Aliases
alias ..="cd .."
alias x="exit"

# Git Aliases

alias add="git add"
alias commit="git commit"
alias pull="git pull"
alias stat="git status"
alias gdiff="git diff HEAD"
alias vdiff="git difftool HEAD"
alias log="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s 
%Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias cfg="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias push="git push"
alias g="lazygit"

alias ssh="TERM=xterm-256color ssh"


alias ios='cd ~/development/mobile_dev/mobilemoc-ios/ && npx react-native run-ios --simulator="iPhone 15 Pro Max" --scheme="Staging" --mode Debug'
alias mobile='cd ~/development/mobile_dev/mobilemoc-ios/'
alias ubuntu='ssh -i /Users/john/.ssh/ubuntu_id_rsa john@192.168.50.75'
alias ubuntu_server='ssh -L 3000:localhost:3000 -i /Users/john/.ssh/ubuntu_id_rsa john@192.168.50.75'



alias mymoc='tmuxinator start mymoc'
alias r_c='tmuxinator start rails_console'
alias front='tmuxinator start front_end'


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

# Sketchybar interactivity overloads
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias n="nnn"
function nnn () {
    command nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
    fi
}
# alias ls='nnn -de'
export NNN_PLUG='l:launch;y:cbcopy-mac;p:cbpaste-mac;v:preview-tui;i:imgview;a:apk-staging;A:apk-prod'
export NNN_FIFO="/tmp/nnn.fifo"
function zen () {
  ~/.config/sketchybar/plugins/zen.sh $1
}

function kill () {
  command kill -KILL $(pidof "$@")
}

function suyabai () {
  SHA256=$(shasum -a 256 /opt/homebrew/bin/yabai | awk "{print \$1;}")
  if [ -f "/private/etc/sudoers.d/yabai" ]; then
    sudo sed -i '' -e 's/sha256:[[:alnum:]]*/sha256:'${SHA256}'/' /private/etc/sudoers.d/yabai
  else
    echo "sudoers file does not exist yet"
  fi
}
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
# export MANPAGER="$(which nvim) +Man!"
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools


export XDG_CONFIG_HOME="$HOME/.config"


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.bin:$PATH"
