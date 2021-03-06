" Grumble Grumble
scriptencoding utf-8
set encoding=utf-8

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
set nowrap
set laststatus=2
set backspace=indent,eol,start

" Ignore this junk
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=*.swp,*~,._*

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
au VimLeave * :!clear

" VIM, RVM and ZSH on OSX gets a little weird
set shell=bash

" Relative line numbers <3
set relativenumber

au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Syntax highlighting
syntax on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display trailing whitespace
set list listchars=tab:»·,trail:·

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Enable spellchecking for git commit messages
  autocmd FileType gitcommit setlocal spell

  " .md is markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " use tabs for golang
  autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

  " use tabs for terraform
  autocmd BufNewFile,BufRead *.tf setlocal noet ts=4 sw=4 sts=4

  " disable tab highlighting
  autocmd BufNewFile,BufRead *.go set nolist

  " use 4 spaces for Objective-C
  autocmd FileType objc setlocal tabstop=4 shiftwidth=4
augroup END

" Use Ag over Grep
set grepprg=ag\ --nogroup\ --nocolor

"""""""""""""""
" Status Line "
"""""""""""""""
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

"""""""""""
" Plugins "
"""""""""""

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Plugin management
Plugin 'gmarik/vundle'
Plugin 'vim-scripts/ZoomWin'

" Ruby ruby ruby ruby!
Plugin 'vim-ruby/vim-ruby'
runtime macros/matchit.vim
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-bundler'

" Awwww yeaaaaaaaa
Plugin 'tpope/vim-unimpaired'

" Handy UNIX stuff
Plugin 'tpope/vim-eunuch'

" Git
Plugin 'tpope/vim-fugitive'

" Rails stuff
Plugin 'tpope/vim-rails'

" Quick file switching
" Plugin 'kien/ctrlp.vim'

set rtp+=~/.fzf
Plugin 'junegunn/fzf.vim'
noremap <C-P> :Files<CR>

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Searching with the silver searcher
Plugin 'rking/ag.vim'

" Commenting
Plugin 'ddollar/nerdcommenter'

" RSpec runner
Plugin 'skalnik/vim-vroom'

let g:vroom_use_dispatch = 1
let g:vroom_use_bundle_exec = 1
let g:vroom_cucumber_path = 'cucumber'

" Use spring if it's available
" Async testing
Plugin 'tpope/vim-dispatch'

" Tab key
Plugin 'ervandew/supertab'

" Syntax checking
Plugin 'scrooloose/syntastic'

" Gist
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'

" Nice way to work on just a small chunk of a file
Plugin 'chrisbra/NrrwRgn'

" Change surroundings
Plugin 'tpope/vim-surround'

" Line things up
Plugin 'godlygeek/tabular'

" Emmet
Plugin 'mattn/emmet-vim'

" Awesomer split navigation
Plugin 'christoomey/vim-tmux-navigator'

" Markdown
Plugin 'itspriddle/vim-marked'

" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Extra syntax / file types
" Bit of a grab bag really!
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-cucumber'
Plugin 'elixir-lang/vim-elixir'
Plugin 'lambdatoast/elm.vim'
Plugin 'jimenezrick/vimerl'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-haml'
Plugin 'nono/vim-handlebars'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-markdown'
Plugin 'mmalecki/vim-node.js'
Plugin 'skwp/vim-rspec'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'posva/vim-vue'

" Objective-C
Plugin 'b4winckler/vim-objc'

" Go
Plugin 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_dispatch_enabled = 1
let g:go_highlight_structs = 1

map <Leader>t :GoTest<CR>
map <Leader>cv :GoCoverage<CR>
map <Leader>a :GoAlternate<CR>

" Please just let me live my life syntastic
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'passive_filetypes': ['go', 'scss'] }

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
map <Leader>s :Ag -i ''<Left>

" Leader-N to open my notes file
map <Leader>n :split ~/Dropbox/notes.txt<CR>

" SRSLY, who actually uses Ex mode?
map Q <Nop>

" Leader-G to open git status and go to first modified file
map <Leader>g :Gstatus<CR>/modified<CR>:noh<CR>
map <Leader>G :Gcommit<CR>ggi

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

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Learn to use vim properly. you muppet
nnoremap <Left> :echoe "Use h. you muppet"<CR>
nnoremap <Right> :echoe "Use l. you muppet"<CR>
nnoremap <Up> :echoe "Use k. you muppet"<CR>
nnoremap <Down> :echoe "Use j. you muppet"<CR>

" Line assignments up
map <Leader>= :Tabularize/=<CR>

" Prettify some JSON
map <Leader>j :%!python -m json.tool<CR>

" Open the current folder in finder
map <Leader>o :!open %:h<CR>

Plugin 'altercation/vim-colors-solarized'
set background=dark
let g:solarized_termtrans = 1
color solarized

" Wrap rails < 4 scope in a lambda
" scope :foos, where(foo: true)
" scope :foos, -> { where(foo: bar) }
map <Leader>l ^f,a -> {A }
