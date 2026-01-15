# NOTE:
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
alias fzf-ri="ri -l | fzf --preview "ri {}" --select-1 --exit-0 | xargs -r ri | nvim +'setlocal buftype=nofile ft=ruby'"

alias ssh="TERM=xterm-256color ssh"

# NOTE: Aliases for killing processes
function kill () {
  command kill -KILL $(pidof "$@")
}


# NOTE: Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# NOTE:  NNN setup required for using imgview
alias n="nnn"
function nnn () {
    command nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
    fi
}
# alias ls='nnn -de'
export NNN_FIFO="/tmp/nnn.fifo"


export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
export MANPAGER="$(which nvim) +Man!"

# Unbind Ctrl+hjkl in zsh so tmux vim-tmux-navigator can handle them
# This allows seamless navigation between vim splits and tmux panes
bindkey -r '^H'  # Remove backward-delete-char
bindkey -r '^J'  # Remove accept-line (Enter key still works)
bindkey -r '^K'  # Remove self-insert
bindkey -r '^L'  # Remove clear-screen (use Ctrl+s L for clear in tmux if needed)



