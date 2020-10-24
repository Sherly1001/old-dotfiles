" Sherly1001's vim settings

set nu
set rnu
set mouse=a
set bo=all
set noudf
set nobk
set ruler
set bs=2

set enc=utf-8

syn enable
syn on
set cul

colo monokai_pro

set list
set lcs=space:.,tab:>-
set fcs=
set cot=menu,longest

set gfn=Consolas\ 14
set go=aegiLrdm

set ic
set is
set hls
set wic
set shm-=S
set ls=2
set stl=%F%=%y%r\ %-14(%3c-%l/%L%)%P

let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"
au vimleave * exe '!echo -ne "\e[ q"'

so ~/.vim/map/map.vim
so ~/.vim/indent/indent.vim
