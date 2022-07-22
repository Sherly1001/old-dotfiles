call plug#begin('~/.config/nvim/plugged')
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'TovarishFin/vim-solidity'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
call plug#end()

so ~/.config/nvim/settings/settings.vim
so ~/.config/nvim/settings/map.vim
so ~/.config/nvim/settings/indent.vim
