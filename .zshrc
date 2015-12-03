# Oh my ZSH! <3
# ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="zhann"
# plugins=(git)
# source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin:$HOME/.bin
export TERM=screen-256color

if [ -n "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"
fi

if [ -n "$(command -v mvim)" ]; then
  alias vi="mvim -v"
  alias vim="mvim -v"
  alias m="mvim"
  export EDITOR="mvim -v"
else
  export EDITOR="vim"
fi

export EDITOR="mvim -v"

# http://robots.thoughtbot.com/post/27985816073/the-hitchhikers-guide-to-riding-a-mountain-lion
export CPPFLAGS=-I/opt/X11/include

# Android SDK
export ANDROID_HOME=/usr/local/opt/android-sdk

# Aliases
alias b="bundle exec"
alias brake="bundle exec rake"
alias ta="tmux attach -t"
alias gl="git l"
alias gst="git status"

# node.js
export PATH="./node_modules/.bin:$PATH"

# Let's a go!
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

alias kill-it-with-fire="git reset --hard HEAD && git-remove-untracked"
