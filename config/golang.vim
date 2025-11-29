" Go Config
filetype plugin indent on

set autowrite

" vim-go settings
let g:go_fmt_command = "goimports"  " Use goimports instead of gofmt
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1      " Don't show errors on failed fmt
let g:go_doc_popup_window = 1       " Show docs in popup window
" gopls
let g:go_bin_path="/usr/local/go/bin/"
let g:go_def_mode = 'gopls'         " Use gopls for definitions
let g:go_info_mode = 'gopls'        " Use gopls for info
let g:go_code_completion_enabled = 1 " Enable code completion

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" End Go config

" Use Tab to trigger and navigate completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"


" General mappings
nmap <silent> <leader>gi :GoImports<CR>
nmap <silent> <leader>gf :GoFmt<CR>
nmap <silent> <leader>gt :GoModTidy<CR>

" Navigation
nmap <silent> gd <Plug>(go-def)
nmap <silent> gy <Plug>(go-def-type)
nmap <silent> gi <Plug>(go-implements)
nmap <silent> gr <Plug>(go-referrers)
nmap <silent> <leader>ds <Plug>(go-def-split)
nmap <silent> <leader>dv <Plug>(go-def-vertical)
nmap <silent> <leader>dt <Plug>(go-def-tab)

" Documentation
nmap <silent> K <Plug>(go-doc)
nmap <silent> <leader>gd <Plug>(go-doc)
nmap <silent> <leader>gv <Plug>(go-doc-vertical)
nmap <silent> <leader>gb <Plug>(go-doc-browser)

" Testing
nmap <silent> <leader>tt :GoTest<CR>
nmap <silent> <leader>tf :GoTestFunc<CR>
nmap <silent> <leader>ta :GoTestAll<CR>
nmap <silent> <leader>tc :GoTestCompile<CR>
nmap <silent> <leader>co :GoCoverage<CR>
nmap <silent> <leader>cb :GoCoverageBrowser<CR>
nmap <silent> <leader>cc :GoCoverageClear<CR>

" Build/Run
nmap <silent> <leader>rb :GoBuild<CR>
nmap <silent> <leader>rr :GoRun<CR>
nmap <silent> <leader>re :GoIfErr<CR>

" Code manipulation
nmap <silent> <leader>ga <Plug>(go-alternate-edit)
nmap <silent> <leader>gah <Plug>(go-alternate-split)
nmap <silent> <leader>gav <Plug>(go-alternate-vertical)
nmap <silent> <leader>fs :GoFillStruct<CR>
nmap <silent> <leader>im :GoImpl<CR>
nmap <silent> <leader>at :GoAddTags<CR>
nmap <silent> <leader>rt :GoRemoveTags<CR>

" LSP mappings (when using gopls)
nmap <silent> <leader>rn <Plug>(go-rename)
nmap <silent> <leader>ca <Plug>(go-code-action)
