
" indent

set ai
filet plugin indent on
set ts=4
set sts=4
set sw=4
set et
set sta
set tw=0

ino {       {}<left>
ino {<cr>   {<cr>}<esc>O
ino {}      {}
ino <expr>  }   getline('.')[col('.')-1] == "}" ? "\<right>" : "}"

ino         (   ()<left>
ino <expr>  )   getline('.')[col('.')-1] == ")" ? "\<right>" : ")"

ino         [   []<left>
ino <expr>  ]   getline('.')[col('.')-1] == "]" ? "\<right>" : "]"

ino <expr>  "   getline('.')[col('.')-1] == "\"" ? "\<right>" : "\"\"\<left>"
ino <expr>  '   getline('.')[col('.')-1] == "\'" ? "\<right>" : "\'\'\<left>"

if expand('%:e') == 'js' || expand('%:e') == 'html' || expand('%:e') == 'css'
    set ts=2
    set sts=2
    set sw=2
endif
