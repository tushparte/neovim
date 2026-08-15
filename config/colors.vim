" colorscheme config
set t_Co=256

" True Colors (must be set before the colorscheme loads)
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set cursorline
lua require('gruvbox').setup({})
colorscheme gruvbox
" let g:airline_theme='onehalfdark'


" old colorscheme config
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'
let g:airline#extensions#tabline#enabled = 1
hi! Normal ctermbg=NONE guibg=NONE

