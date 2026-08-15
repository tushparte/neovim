call plug#begin('~/.vim/plugged')

Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'honza/vim-snippets'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main', 'do': ':TSUpdate' }


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

let mapleader = " "

source $HOME/.config/nvim/config/sets.vim
source $HOME/.config/nvim/config/colors.vim
source $HOME/.config/nvim/config/golang.vim
source $HOME/.config/nvim/config/telescope.vim
source $HOME/.config/nvim/config/remaps.vim

" LSP Keymaps
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" Treesitter
lua << EOF
local ts_parsers = { 'go', 'gomod', 'gowork', 'gosum', 'c', 'lua', 'vim', 'vimdoc', 'bash', 'markdown' }
require('nvim-treesitter').install(ts_parsers)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'gomod', 'gowork', 'gosum', 'c', 'lua', 'vim', 'help', 'bash', 'sh', 'markdown' },
  callback = function()
    vim.treesitter.start()
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
EOF

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


-- Setup LSP for Go
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.lsp.start({
      name = 'gopls',
      cmd = {'gopls'},
      capabilities = capabilities,
      root_dir = vim.fs.dirname(vim.fs.find({'go.mod', '.git'}, { upward = true })[1]),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            nonewvars = true,
            shadow = true,
            undeclaredname = true,
          },
          staticcheck = true,
          gofumpt = true,  -- If you want to use gofumpt
          usePlaceholders = true,
          completeUnimported = true,
        }
      }
    })
  end,
})


-- Setup LSP for C
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'cpp', 'h', 'hpp'},
  callback = function()
    vim.lsp.start({
      name = 'clangd',
      cmd = {'clangd'},
      capabilities = capabilities,
      root_dir = vim.fs.dirname(vim.fs.find({'compile_commands.json', '.git'}, { upward = true })[1]),
      init_options = {
        clangdFileStatus = true,
        fallbackFlags = { "-std=c++17", "-Wall", "-Wextra" }  -- Add C++ standard here
      }
    })
  end,
})

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set({'n', 'x'}, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code actions" })

-- Optional: Setup LuaSnip
require('luasnip.loaders.from_vscode').lazy_load()

require('lspconfig').gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Enable format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end
    })
  end
})
EOF

