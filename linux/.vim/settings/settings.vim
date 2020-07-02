
" Sherly1001's vim settings

set nu
set mouse=a
set noundofile
set nobackup
set ruler
set backspace=indent,eol,start

set encoding=utf-8

" set lines=35
" set columns=135

syntax enable
syntax on
set cursorline

colorscheme monokai
hi normal ctermbg=NONE
" monokai theme
" color elflord

set guifont=Consolas\ 14

set incsearch
set hls

so ~/.vim/map/map.vim
so ~/.vim/indent/indent.vim