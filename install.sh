#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

symlink() {
  src=$DOTFILES_DIR/$1
  dst=$HOME/$1

  if [[ -e "$dst" ]]; then
    echo "EXISTS: $dst"
  else
    echo "SYMLINK: $src → $dst"
    ln -sf "$src" "$dst"
  fi
}

# Git
symlink .gitconfig
symlink .git_template
symlink .gitignore_global

# Tmux
symlink .tmux.conf

# Ruby
symlink .irbrc

# ZSH
symlink .zshrc

# Binaries
symlink bin

# Vim
symlink .vimrc
symlink .gvimrc
symlink .vim
vim +PluginInstall +qall
