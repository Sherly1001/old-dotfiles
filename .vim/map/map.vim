
" mapping key

map <silent> ;hl :set hls!<cr>

vmap <bs> x
imap kk <esc>
nmap <Space> <Pagedown>
nmap <S-Space> <Pageup>
imap <silent> <c-a> kkggVG
map <silent> <c-a> ggVG
map <silent> <C-X> "+x
map <silent> <C-C> "+y
imap <silent> <C-V> <esc>"+gpa
map <silent> ;n<cr> :tabnew<cr>
map <silent> <c-t> :browse confirm tabnew<cr>
map <silent> <c-left> :tabp<cr>
map <silent> <c-right> :tabn<cr>
map <silent> ;rc :e ~/.vimrc<cr>
map <silent> ;s :e ~/.vim/settings/settings.vim<cr>
map <silent> ;ind :e ~/.vim/indent/indent.vim<cr>
map <silent> ;m :e ~/.vim/map/map.vim<cr>
map <silent> ;rl so ~/.vimrc<cr>
