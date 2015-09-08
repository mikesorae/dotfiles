### aliases

alias ll='ls -la'
alias ls='ls -la'
alias rm="trash"
alias openwithvim="open -a /Applications/MacVim.app"
alias ql='qlmanage -p $@ >& /dev/null'
alias cal="gcal -i"

### zsh plugins
plugins=(git)
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

### Utility functions

function gi() { curl -L https://www.gitignore.io/api/$@ ;}

function rbserver() {
  if [ $# -eq 0 ]; then
    echo "USAGE: rbserver portnumber"
    return
  fi
  ruby -run -e httpd . -p $@
}

function filter-branch-email() {
  git filter-branch -f --env-filter "export GIT_AUTHOR_EMAIL=$1"
}

function filter-branch-name() {
  git filter-branch -f --env-filter "export GIT_AUTHOR_NAME=$1"
}

### export paths

export PATH="/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/Applications/adt/tools/:$PATH"

### for tmux
export EDITOR='vi'
export SHELL='zsh'

### zsh prompt setting
autoload colors
colors

### zsh-completions
fpath=(/opt/boxen/homebrew/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -u

### ignore case
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# save history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
function history-all { history -E 1 }
setopt inc_append_history
setopt share_history

### keybinding
bindkey -e

### rbenv
eval "$(rbenv init -)"

### nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
