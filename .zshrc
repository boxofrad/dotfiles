export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin:$HOME/bin
export TERM=screen-256color

# Node.js (ugh)
export PATH="./node_modules/.bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Editor
if [ -n "$(command -v mvim)" ]; then
  export EDITOR="mvim -v"
  alias vim="mvim -v"
else
  export EDITOR=vim
fi
alias vi="vim"

# Shortcuts
alias b="bundle exec"
alias brake="bundle exec rake"
alias ta="tmux attach -t"
alias gl="git l"
alias gst="git status"

# C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# C-r and C-f to search history
bindkey '\C-r' history-incremental-search-backward
bindkey '\C-f' history-incremental-search-forward

# Start typing then hit <Up> for context aware history
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Prompt
setopt PROMPT_SUBST
fpath=(~/.zsh $fpath)
autoload -U promptinit
promptinit
autoload -U colors
colors
prompt boxofrad
