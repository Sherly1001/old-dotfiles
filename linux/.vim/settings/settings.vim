" Sherly1001's vim settings

set nu
set rnu
set mouse=a
set bo=all
set noudf
set nobk
set bs=2

set enc=utf-8

syn enable
syn on
set cul

if has('gui_running') || &t_Co > 255
    colo monokai_pro
    set list
    set lcs=space:.,tab:>-
endif

set fcs=
set cot=menu,longest

set gfn=Consolas\ 14
set go=aegid

set ic
set is
set hls
set wic
set shm-=S
set ls=2
set stl=%F%=%y%r\ %-14(%3c-%l/%L%)%P

if !has('gui_running')
    let &t_SI = "\e[5 q"
    let &t_SR = "\e[3 q"
    let &t_EI = "\e[1 q"
    au vimleave * sil! exe '!echo -ne "\e[ q"'
endif

so ~/.vim/map/map.vim
so ~/.vim/indent/indent.vim
