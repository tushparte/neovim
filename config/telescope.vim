" Telescope config
lua << EOF
require('telescope').setup({})
EOF

nnoremap <silent> <Leader>b :Telescope buffers<CR>
nnoremap <silent> <C-f> :Telescope find_files<CR>
nnoremap <silent> <C-F> :Telescope git_files<CR>
nnoremap <silent> <Leader>rg :Telescope live_grep<CR>
nnoremap <silent> <Leader>ht :Telescope help_tags<CR>
