
" mapping key

map <silent> ;ic :set ic!<cr>
map <silent> ;hl :set hls!<cr>
nmap <silent> <esc><esc> :nohls<cr>

vmap <bs> x
imap kk <esc>
nmap <space> <pagedown>
nmap <s-space> <pageup>
imap <silent> <c-a> <esc>ggVG
map <silent> <c-a> ggVG
map <silent> <c-x> "+x
map <silent> <c-c> "+y
imap <silent> <c-v> <esc>"+gpa
map <silent> ;n<cr> :tabnew<cr>
map <silent> <c-t> :browse confirm tabnew<cr>
map <silent> <c-left> :tabp<cr>
map <silent> <c-right> :tabn<cr>
map <silent> <c-j> :resize +5<cr>
map <silent> <c-k> :resize -5<cr>
map <silent> <c-h> :vertical resize -5<cr>
map <silent> <c-l> :vertical resize +5<cr>
map <silent> ;rc :e ~/.vimrc<cr>
map <silent> ;s :e ~/.vim/settings/settings.vim<cr>
map <silent> ;ind :e ~/.vim/indent/indent.vim<cr>
map <silent> ;m :e ~/.vim/map/map.vim<cr>
map <silent> ;rl :so ~/.vimrc<cr>
map <silent> ;t :bel ter ++close<cr>
tno <silent> <c-n> <c-\><c-n>

map <silent> ;cl :ColorToggle<cr>
map <silent> ;nt :NERDTreeToggle<cr>
