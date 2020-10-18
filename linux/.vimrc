
call plug#begin('~/.vim/plugins')
Plug 'chrisbra/Colorizer'
Plug 'preservim/nerdtree'
Plug 'ervandew/supertab'
call plug#end()

set rtp+=~/.vim/autoload
so ~/.vim/settings/settings.vim
