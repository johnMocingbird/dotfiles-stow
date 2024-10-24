# =======================  Imports   ===============================
# ==================================================================
# ==================================================================

if [ -f ~/.config/zsh/omz_and_p10k.zsh ]; then
    source ~/.config/zsh/omz_and_p10k.zsh
fi
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
export NNN_FIFO="/tmp/nnn.fifo"

function kill () {
  command kill -KILL $(pidof "$@")
}

alias am=zsh /Users/john/development/Apple-Music-CLI-Player/src/am.sh

export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"



source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

export XDG_CONFIG_HOME="$HOME/.config"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.bin:$PATH"
