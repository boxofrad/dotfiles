# Oh my ZSH! <3
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="zhann"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/local/sbin
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

# NPM
PATH=$PATH:/usr/local/share/npm/bin
