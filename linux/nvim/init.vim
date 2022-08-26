call plug#begin('~/.config/nvim/plugged')

" utils plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" base plugins
Plug 'lilydjwg/colorizer'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'lukas-reineke/indent-blankline.nvim'

" git plugins
Plug 'zivyangll/git-blame.vim'
Plug 'airblade/vim-gitgutter'

" lang plugins
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'TovarishFin/vim-solidity'

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

call plug#end()

so ~/.config/nvim/settings/settings.vim
so ~/.config/nvim/settings/map.vim
so ~/.config/nvim/settings/indent.vim
