""""""""""""""
" The Basics "
""""""""""""""

set nocompatible
set nobackup
set nowritebackup
set noswapfile
set history=500
set ruler
set showcmd
set incsearch
set ignorecase
set smartcase
set laststatus=2

" VIM, RVM and ZSH on OSX gets a little weird
set shell=bash

" Relative line numbers <3
set relativenumber

" Syntax highlighting
syntax on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display trailing whitespace
set list listchars=tab:»·,trail:·

""""""""""
" Colour "
""""""""""

set t_Co=256
set background=dark
color grb256

"""""""""""""""
" Status Line "
"""""""""""""""
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

"""""""""""
" Plugins "
"""""""""""

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugin management
Bundle 'gmarik/vundle'

" Git
Bundle 'tpope/vim-fugitive'

" Rails stuff
Bundle 'tpope/vim-rails'

" Quick file switching
Bundle 'kien/ctrlp.vim'

" Searching with the silver searcher
Bundle 'rking/ag.vim'

" Commenting
Bundle 'ddollar/nerdcommenter'

" RSpec runner
Bundle 'skalnik/vim-vroom'

" Tab key
Bundle 'ervandew/supertab'

" Syntax checking
Bundle 'scrooloose/syntastic'

" Gist
Bundle 'mattn/gist-vim'

" Nice way to work on just a small chunk of a file
Bundle 'chrisbra/NrrwRgn'

" Change surroundings
Bundle 'tpope/vim-surround'

" Line things up
Bundle 'godlygeek/tabular'

" Emmet
Bundle 'mattn/emmet-vim'

" Snippets
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle "tomtom/tlib_vim"
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

" Extra syntax / file types
" Bit of a grab bag really!
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-cucumber'
Bundle 'elixir-lang/vim-elixir'
Bundle 'jimenezrick/vimerl'
Bundle 'tpope/vim-git'
Bundle 'jnwhiteh/vim-golang'
Bundle 'tpope/vim-haml'
Bundle 'nono/vim-handlebars'
Bundle 'pangloss/vim-javascript'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-markdown'
Bundle 'mmalecki/vim-node.js'
Bundle 'tpope/vim-rails'
Bundle 'skwp/vim-rspec'
Bundle 'vim-ruby/vim-ruby'
Bundle 'cakebaker/scss-syntax.vim'

filetype plugin indent on

"""""""""""""""""""""""
" Custom Key Bindings "
"""""""""""""""""""""""

" 11 Inch MacBook Air (lovely but has a tiny escape key)
map § <Esc>
imap § <Esc>

" Quickly resize split
map <Leader>[ 10<C-w>+
map <Leader>] 10<C-w>-

map <Leader>- 10<C-w><
map <Leader>= 10<C-w>>

" Double tap leader to even out the splits
map <Leader><Leader> <C-w>=

" Leader-Y to trigger emmet
map <Leader>y <C-Y>,
imap <Leader>y <C-Y>,

" Leader-S to search
map <Leader>s :Ag ''<Left>

" Leader-N to open my notes file
map <Leader>n :split ~/Dropbox/notes.txt<CR>

" SRSLY, who actually uses Ex mode?
map Q <Nop>

" Leader-G to open git status and go to first modified file
map <Leader>g :Gstatus<CR>/modified<CR>:noh<CR>

" Leader-dp to stage a hunk
map <Leader>dp :diffput<CR>

""""""""""""""
" Epic Hacks "
""""""""""""""

" I hate the way vim yanks when I paste over something. BE MAD.
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

vnoremap <silent> <expr> p <sid>Repl()

function! PromoteToLet()
  normal! dd
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
:command! RenameFile :call RenameFile()
