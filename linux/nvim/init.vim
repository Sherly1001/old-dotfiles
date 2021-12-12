call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'pangloss/vim-javascript'
" Plug 'leafOfTree/vim-vue-plugin'
call plug#end()

so ~/.config/nvim/settings/settings.vim
so ~/.config/nvim/settings/map.vim
so ~/.config/nvim/settings/indent.vim
