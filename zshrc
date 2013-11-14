# Oh my ZSH! <3
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="zhann"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin:$HOME/bin
export TERM=xterm-256color

# RVM or rbenv... depending on my mood
if [ -d $HOME/.rvm ]; then
  PATH=$PATH:$HOME/.rvm/bin
  cd ..;1 >> /dev/null # tmux hack
elif which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

if [ `which mvim` != "" ]; then
  alias vi="mvim -v"
  alias vim="mvim -v"
fi

# http://robots.thoughtbot.com/post/27985816073/the-hitchhikers-guide-to-riding-a-mountain-lion
export CPPFLAGS=-I/opt/X11/include

# Android SDK
export ANDROID_HOME=/usr/local/opt/android-sdk

# Secret stuff I don't want on github
source ~/Dropbox/private.zsh

# Aliases
alias b="bundle exec"
alias kcc-ip="curl -u '$KCC_IP_CREDENTIALS' http://kcc-ip-tracker.herokuapp.com/current"

# node.js
export PATH="./node_modules/.bin:$PATH"

# Let's a go!
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
