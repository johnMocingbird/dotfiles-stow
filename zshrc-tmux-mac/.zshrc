if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:/usr/local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster")
CASE_SENSITIVE="true"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode disabled

zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"

DISABLE_LS_COLORS="false"

DISABLE_AUTO_TITLE="true"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy"

plugins=(gh git rails tmux iterm2 web-search)
source $ZSH/oh-my-zsh.sh

if [[ "$(uname)" == "Darwin" ]]; then
  if [ -f ~/.config/zsh/macos.zsh ]; then
    source ~/.config/zsh/macos.zsh
  fi
fi

if [ -f ~/.config/zsh/general.zsh ]; then
  source ~/.config/zsh/general.zsh
fi

if [ -f ~/.config/zsh/plugins.zsh ]; then
  source ~/.config/zsh/plugins.zsh
else
  echo "plugins.zsh file not found"
fi

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

alias am=zsh /Users/john/development/Apple-Music-CLI-Player/src/am.sh

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
