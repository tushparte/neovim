" Telescope config
lua << EOF
require('telescope').setup({})
EOF

nnoremap <silent> <Leader>b :Telescope buffers<CR>
nnoremap <silent> <C-f> :Telescope find_files<CR>
nnoremap <silent> <Leader>rg :Telescope live_grep<CR>
nnoremap <silent> <Leader>ht :Telescope help_tags<CR>

" Quick global search bindings
nnoremap <silent> <Leader><Leader> :Telescope find_files<CR>
nnoremap <silent> <C-F> :Telescope live_grep<CR>

" search the word under cursor project-wide (fallback for macro-expanded
" symbols clangd can't resolve, e.g. SQLite's SQLITE_API/OMIT macros)
nnoremap <silent> <Leader>rw :Telescope grep_string<CR>

" LSP pickers through Telescope (nicer than quickfix for large result sets)
nnoremap <silent> <Leader>lr :Telescope lsp_references<CR>
nnoremap <silent> <Leader>ls :Telescope lsp_document_symbols<CR>
nnoremap <silent> <Leader>lw :Telescope lsp_dynamic_workspace_symbols<CR>
