
" indent

set autoindent
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set textwidth=0

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {}     {}
inoremap <expr> }  getline('.')[col('.')-1] == "}" ? "\<Right>" : "}"

inoremap        (  ()<Left>
inoremap <expr> )  getline('.')[col('.')-1] == ")" ? "\<Right>" : ")"

inoremap        [  []<Left>
inoremap <expr> ]  getline('.')[col('.')-1] == "]" ? "\<Right>" : "]"

inoremap <expr> "  getline('.')[col('.')-1] == "\"" ? "\<Right>" : "\"\"\<Left>"
inoremap <expr> '  getline('.')[col('.')-1] == "\'" ? "\<Right>" : "\'\'\<Left>"

if expand('%:e') == 'js' || expand('%:e') == 'html' || expand('%:e') == 'css'
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endif
