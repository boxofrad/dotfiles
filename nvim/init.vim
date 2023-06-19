"""""""""""
" Plugins "
"""""""""""
call plug#begin()

" Color scheme
Plug 'micha/vim-colors-solarized'

" Fuzzy Finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Vim + Tmux <3
Plug 'christoomey/vim-tmux-navigator'

" Fancy IDE stuff (completion, go to definition etc)
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

" Syntax highlighting, indentation, folding etc.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Handy unix stuff
Plug 'tpope/vim-eunuch'

" Run stuff in the background
Plug 'tpope/vim-dispatch'

" Testing
Plug 'vim-test/vim-test'
let g:test#strategy = 'dispatch'

" Commenting stuff out
Plug 'preservim/nerdcommenter'

" Gist
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'

" Change surroundings
Plug 'tpope/vim-surround'

" Search with ripgrep
Plug 'jremmen/vim-ripgrep'

call plug#end()

" Leader key
let mapleader = ";"

" Running tests
nnoremap <silent> <Leader>t :TestNearest<CR>
nnoremap <silent> <Leader>T :TestFile<CR>
nnoremap <silent> gt :TestVisit<CR>

" Alternate file similar to :A in rails.vim
function! GolangAlternate()
  let filename = expand('%')

  if match(filename, '_test') != -1
    let alternate = substitute(filename,  '_test.go$', '.go', 'g')
  else
    let alternate = substitute(filename,  '.go$', '_test.go', 'g')
  endif

  execute "edit" alternate
endfunction

au FileType go nmap <Leader>a :call GolangAlternate()<CR>

" Remember previous position in file (usedful with GolangAlternate).
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Trigger fuzzy finder
nnoremap <C-P> <cmd>Telescope find_files<CR>
nnoremap <Leader>s <cmd>Telescope live_grep<CR>

" Git
nnoremap <Leader>g :Gstatus<CR>
nnoremap <Leader>G :Gcommit<CR>

augroup vimrcEx
  autocmd!

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
  autocmd BufNewFile,BufRead go.mod set nolist
augroup END

" Mardown formatting
au filetype markdown set formatoptions+=ro
au filetype markdown set comments=b:*,b:-,b:+,b:1.,n:>

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Nice searching
set incsearch
set ignorecase
set smartcase


" Color scheme
set background=light
color solarized

" Crosshair
set cursorline cursorcolumn

" Sign column (used for LSP errors etc)
set scl=yes

" Display trailing whitespace
set list listchars=tab:»·,trail:·

" Map the danish dollar key (MacBook Keyboard) to escape
map § <Esc>
imap § <Esc>

" Quickly moving between next/prev results (e.g. in :grep)
map ]q :cnext<CR>
map [q :cprev<CR>

" Completion
set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      {
        name = 'buffer',
        opts = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      },
      { name = 'path' },
    }
  })
EOF

" LSP Stuff
lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

nvim_lsp.gopls.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  -- TODO: Figure out how to set this dynamically based on the project.
  -- settings = {
  --   gopls = {
  --     ["local"] = "github.com/hashicorp/..."
  --   }
  -- }
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'terraformls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" Telescope
lua <<EOF
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = 'move_selection_next',
        ['<C-k>'] = 'move_selection_previous',
      }
    }
  }
}
EOF

" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- TODO: Protobufs
  ensure_installed = { 'go', 'gomod', 'hcl', 'javascript', 'ruby', 'query' },
  highlight = {
    enable = true
  },
}
EOF

lua <<EOF
function goimports(timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end

  vim.lsp.buf.formatting_sync()
end
EOF

" Run goimports (via LSP) on save.
autocmd BufWritePre *.go lua goimports(1000)
