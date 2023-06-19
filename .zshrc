ulimit -n 200000
ulimit -u 2048

export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/sbin
export TERM=screen-256color

# Node.js (ugh)
export PATH="./node_modules/.bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Go
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export GOPRIVATE=github.com/hashicorp

# Handy function for grabbing a module pseudo-version.
go-mod-version() {
  date_version=$(
    TZ=UTC git --no-pager show \
    --quiet \
    --abbrev=12 \
    --date='format-local:%Y%m%d%H%M%S' \
    --format="%cd-%h"
  )

  echo "v0.0.0-$date_version"
}

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Editor
if [ -n "$(command -v nvim)" ]; then
  alias ogvim=/usr/local/bin/vim
  export EDITOR="nvim"
  alias vim="nvim"
  alias vi="nvim"
else
  export EDITOR=vim
fi

# Tmux
alias ta="tmux attach -t"

# Git
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

# Local customizations
if [ -e $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi
