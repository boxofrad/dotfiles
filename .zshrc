export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin:$HOME/bin
export TERM=screen-256color

# Node.js (ugh)
export PATH="./node_modules/.bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Load profile.d on work VM
if [ -d /etc/profile.d ]; then
  for file in /etc/profile.d/*; do
    source $file
  done
fi

# Ruby
CHRUBY_SCRIPTS=(
  # Homebrew
  /usr/local/opt/chruby/share/chruby/chruby.sh
  /usr/local/opt/chruby/share/chruby/auto.sh

  # Linux / From Source
  /usr/local/share/chruby/chruby.sh
  /usr/local/share/chruby/auto.sh
)

for script in $CHRUBY_SCRIPTS; do
  if [ -f $script ]; then
    source $script
  fi
done

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

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
alias gp="git push"
alias gst="git status"

gpu() {
  git push -u origin $(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
}

# C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# C-r and C-f to search history
bindkey '\C-r' history-incremental-search-backward
bindkey '\C-f' history-incremental-search-forward

# C-a beginning of line
bindkey '\C-a' beginning-of-line

# C-e end of line
bindkey '\C-e' end-of-line

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

if [ -e $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi
