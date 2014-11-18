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
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
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

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " .md is markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " use tabs for golang
  autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

  " disable tab highlighting
  autocmd BufNewFile,BufRead *.go set nolist
augroup END

" Use Ag over Grep
set grepprg=ag\ --nogroup\ --nocolor

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

" Ruby ruby ruby ruby!
Bundle 'vim-ruby/vim-ruby'
runtime macros/matchit.vim
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-bundler'

" Handy UNIX stuff
Bundle 'tpope/vim-eunuch'

" Git
Bundle 'tpope/vim-fugitive'

" Rails stuff
Bundle 'tpope/vim-rails'

" Quick file switching
Bundle 'kien/ctrlp.vim'

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Searching with the silver searcher
Bundle 'rking/ag.vim'

" Commenting
Bundle 'ddollar/nerdcommenter'

" RSpec runner
Bundle 'skalnik/vim-vroom'

let g:vroom_use_dispatch = 1
let g:vroom_use_bundle_exec = 0
let g:vroom_use_spring = 1
let g:vroom_cucumber_path = 'cucumber'

" Async testing
Bundle 'tpope/vim-dispatch'

" Tab key
" Bundle 'ervandew/supertab'
Bundle 'Valloric/YouCompleteMe'

" Syntax checking
Bundle 'scrooloose/syntastic'

" File tree
Bundle 'scrooloose/nerdtree'

" Gist
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'

" Nice way to work on just a small chunk of a file
Bundle 'chrisbra/NrrwRgn'

" Change surroundings
Bundle 'tpope/vim-surround'

" Line things up
Bundle 'godlygeek/tabular'
let g:go_fmt_command = "goimports"

" Emmet
Bundle 'mattn/emmet-vim'

" Markdown
Bundle 'itspriddle/vim-marked'

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
Bundle 'fatih/vim-go'
Bundle 'tpope/vim-haml'
Bundle 'nono/vim-handlebars'
Bundle 'pangloss/vim-javascript'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-markdown'
Bundle 'mmalecki/vim-node.js'
Bundle 'skwp/vim-rspec'
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

" Tabularize the hashrocket
map <Leader>t :Tabularize/=><CR>

" Line assignments up
map <Leader>= :Tabularize/=<CR>

" Prettify some JSON
map <Leader>j :%!python -m json.tool<CR>

" Open the current folder in finder
map <Leader>o :!open %:h<CR>

" Kick off XCode build on "Project X"
map <D-r> :Dispatch! make run <CR>

" Project specific stuff
if filereadable(".dupton")
  source .dupton
endif

set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

" Wrap rails < 4 scope in a lambda
" scope :foos, where(foo: true)
" scope :foos, -> { where(foo: bar) }
map <Leader>l ^f,a -> {A }

" Markdown
map <Leader>m :MarkedOpen!<CR>
