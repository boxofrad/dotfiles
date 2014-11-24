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
alias brake="bundle exec rake"
alias g="git"
alias t="bundle exec rspec"
alias r="bundle exec rails"
alias rgm="bundle exec rails g migration"
alias work="cd ~/work"
alias src="cd ~/src"
alias dotfiles="cd ~/src/dotfiles"
alias ta="tmux attach -t"

# Fast things on rails
alias srails="spring rails"
alias sconsole="spring rails console"
alias srspec="spring rspec"
alias srake="spring rake"

alias sr="spring rspec"
alias rk="spring rake"
alias rl="spring rails"
alias rlc="spring rails console"

alias m="mvim"

kcc-ip() {
  curl -u "$KCC_IP_CREDENTIALS" http://kcc-ip-tracker.herokuapp.com/current
  echo
}

# start a rails server on the first available port
server() {
  port=3000
  while lsof -i :$port >> /dev/null
  do
    port=$[$port +1]
  done
  bundle exec rails server -p $port
}

# node.js
export PATH="./node_modules/.bin:$PATH"

# Let's a go!
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Private stuff
source $HOME/Dropbox/private.zsh
export EDITOR="mvim -v"
PATH=~/src/dotfiles/bin:$PATH

rawr() {
  rails new $1 -T --skip-bundle -d mysql -m http://dev.rawnet.com/files/rails-application-template.rb
}

password-hash() {
  openssl passwd -1 $1
}

git-remove-untracked() {
  git status --porcelain | grep '^??' | awk '{print $2}' | xargs rm
}

alias kill-it-with-fire="git reset --hard HEAD && git-remove-untracked"
