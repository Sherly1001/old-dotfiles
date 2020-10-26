
" indent

set ai
filet plugin indent on
set ts=4
set sts=4
set sw=4
set et
set sta
set tw=0

if expand('%:e') == 'js' || expand('%:e') == 'html' || expand('%:e') == 'css'
    set ts=2
    set sts=2
    set sw=2
endif
