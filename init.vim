call plug#begin('~/.vim/plugged')

Plug 'jremmen/vim-ripgrep'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'flazz/vim-colorschemes'
Plug 'honza/vim-snippets'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" Auto-completion
Plug 'neovim/nvim-lspconfig', { 'tag': 'v0.1.7' }
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

call plug#end()

source $HOME/.config/nvim/config/sets.vim
source $HOME/.config/nvim/config/colors.vim
source $HOME/.config/nvim/config/golang.vim
source $HOME/.config/nvim/config/fzf.vim
source $HOME/.config/nvim/config/remaps.vim

" LSP Keymaps
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" Enable LSP and completion
lua << EOF
-- Setup cmp with better configuration
local cmp = require'cmp'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  })
})

-- Setup LSP for C
require('lspconfig').clangd.setup({
  capabilities = capabilities
})

-- Optional: Setup LuaSnip
require('luasnip.loaders.from_vscode').lazy_load()
EOF

