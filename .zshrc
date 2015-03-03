### aliases

alias ll='ls -l'
alias ls='ls -la'
alias rm="trash"
alias openwithvim="open -a /Applications/MacVim.app"
alias ql='qlmanage -p $@ >& /dev/null'
alias cal="gcal -i"

### Utility functions

function gi() { curl -L https://www.gitignore.io/api/$@ ;}

function rbserver() {
  if [ $# -eq 0 ]; then
    echo "USAGE: rbserver portnumber"
    return
  fi
  ruby -run -e httpd . -p $@
}

export PATH="/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/Applications/adt/tools/:$PATH"

### for tmux
export EDITOR='vi'
export SHELL='zsh'

### zsh prompt setting
autoload colors
colors

PROMPT="%{${fg[green]}%}(@p@)%n@%~$%{${reset_color}%} "
PROMPT2='> '

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
