# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

### aliases

alias ls='ls -l'
alias ll='ls -la'
alias lm='ls -la | less'
alias rm="trash"
alias openwithvim="open -a /Applications/MacVim.app"
alias ql='qlmanage -p $@ >& /dev/null'
alias cal="gcal -i"
alias md2pdf='markdown-pdf -s ~/.css/github.css'
alias be='bundle exec'

alias git-search-branch='git branch -r --merged | grep $@'

### Utility functions

function gi() { curl -L https://www.gitignore.io/api/$@ ;}

function rbserver() {
  if [ $# -eq 0 ]; then
    echo "USAGE: rbserver portnumber"
    return
  fi
  ruby -run -e httpd . -p $@
}

function docker-machine-up() {
  docker-machine start default
  eval "$(docker-machine env default)"  
}

function filter-branch-email() {
  git filter-branch -f --env-filter "export GIT_AUTHOR_EMAIL=$1"
}

function filter-branch-name() {
  git filter-branch -f --env-filter "export GIT_AUTHOR_NAME=$1"
}

function use_java7() {
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
}

function use_java8() {
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
}

### export paths

export PATH="/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/Applications/adt/tools/:$PATH"

### for tmux
export EDITOR='vi'
export VISUAL='vi'
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
export HISTFILE=$HOME/.zsh-history
export HISTSIZE=100000
export SAVEHIST=100000
setopt extended_history
function history-all { history -E 1 }
setopt inc_append_history
setopt share_history

# ansible environments
export ANSIBLE_COW_SELECTION=random

### keybinding
bindkey -e

### rbenv
eval "$(rbenv init -)"

### nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

### java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

### docker-machine
eval "$(docker-machine env default)"  

### pecoでhistory検索
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
