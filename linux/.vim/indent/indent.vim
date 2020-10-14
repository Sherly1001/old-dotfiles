
" indent

set ai
filet plugin indent on
set ts=4
set sts=4
set sw=4
set et
set sta
set tw=0

ino {       {}<Left>
ino {<CR>   {<CR>}<Esc>O
ino {}      {}
ino <expr>  }   getline('.')[col('.')-1] == "}" ? "\<Right>" : "}"

ino         (   ()<Left>
ino <expr>  )   getline('.')[col('.')-1] == ")" ? "\<Right>" : ")"

ino         [   []<Left>
ino <expr>  ]   getline('.')[col('.')-1] == "]" ? "\<Right>" : "]"

ino <expr>  "   getline('.')[col('.')-1] == "\"" ? "\<Right>" : "\"\"\<Left>"
ino <expr>  '   getline('.')[col('.')-1] == "\'" ? "\<Right>" : "\'\'\<Left>"

if expand('%:e') == 'js' || expand('%:e') == 'html' || expand('%:e') == 'css'
    set ts=2
    set sts=2
    set sw=2
endif
