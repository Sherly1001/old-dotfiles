" Sherly1001's vim settings

set nu
set rnu
set mouse=a
set noundofile
set nobk
set ruler
set backspace=indent,eol,start

set encoding=utf-8

syntax enable
syntax on
set cul

colorscheme monokai_pro

set list
set listchars=space:.,tab:>-
set fillchars=

set gfn=Consolas\ 14

set ic
set is
set hls
set wic
set shm-=S
set ls=2
set stl=%F%=%y%r\ %-12(%c-%l/%L%)%P

so ~/.vim/map/map.vim
so ~/.vim/indent/indent.vim
