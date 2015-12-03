# Oh my ZSH! <3
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="zhann"
plugins=(git)
source $ZSH/oh-my-zsh.sh

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

# Secret stuff I don't want on github
if [ -f ~/Dropbox/private.zsh ]; then
  source ~/Dropbox/private.zsh
fi

# Aliases
alias b="bundle exec"
alias brake="bundle exec rake"

if [ -n "$(command -v hub)" ]; then
  alias git="hub"
fi

alias twr="gittower"
alias g="git"
alias t="bundle exec rspec"
alias r="bundle exec rails"
alias rgm="bundle exec rails g migration"
alias work="cd ~/work"
alias src="cd ~/src"
alias dotfiles="cd ~/.dotfiles"
alias ta="tmux attach -t"
alias gl="git l"
alias gpom="git push origin master"
alias gdo="git down"

# Fast things on rails
alias srails="spring rails"
alias sconsole="spring rails console"
alias srspec="spring rspec"
alias srake="spring rake"

alias sr="spring rspec"
alias rk="spring rake"
alias rl="spring rails"
alias rlc="spring rails console"
alias mig="spring rake db:migrate"
alias cpd="bundle exec cap production deploy:migrations"
alias csd="bundle exec cap staging deploy:migrations"

rb() {
  step=$1

  if [ -z "$step" ]; then
    step=1
  fi

  spring rake db:rollback STEP=$step
  spring rake db:rollback STEP=$step RAILS_ENV=test
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

rawr() {
  rails new $1 -T --skip-bundle -d mysql -m http://dev.rawnet.com/files/rails-application-template.rb
}

password-hash() {
  openssl passwd -1 $1
}

git-remove-untracked() {
  git status --porcelain | grep '^??' | awk '{print $2}' | xargs rm
}

install-project-ruby() {
  rbenv install `cat .ruby-version` && gem update --system && gem install bundler
}

alias kill-it-with-fire="git reset --hard HEAD && git-remove-untracked"
