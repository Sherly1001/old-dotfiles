
" indent

set autoindent
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set textwidth=0

set list
set listchars=space:.,tab:>-
hi NonText guifg=#4a4a59 ctermfg=237
hi SpecialKey guifg=#4a4a59 ctermfg=237

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"


if expand('%:e') == 'js' || expand('%:e') == 'html' || expand('%:e') == 'css' 
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endif
