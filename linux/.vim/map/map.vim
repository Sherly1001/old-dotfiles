
" mapping key

map <silent> ;ic :set ic!<cr>
map <silent> ;hl :set hls!<cr>
nmap <silent> <esc><esc> :nohls<cr>

map <silent> Q :q!<cr>
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
map <silent> <c-t> :bro conf tabnew<cr>
map <silent> <c-left> :tabp<cr>
map <silent> <c-right> :tabn<cr>
map <silent> <c-j> :res +5<cr>
map <silent> <c-k> :res -5<cr>
map <silent> <c-h> :vert res -5<cr>
map <silent> <c-l> :vert res +5<cr>
map <silent> ;rc :e ~/.vimrc<cr>
map <silent> ;s :e ~/.vim/settings/settings.vim<cr>
map <silent> ;ind :e ~/.vim/indent/indent.vim<cr>
map <silent> ;m :e ~/.vim/map/map.vim<cr>
map <silent> ;rl :so ~/.vimrc<cr>
map <silent> ;t :bel ter ++close<cr>
tno <silent> <c-n> <c-\><c-n>

map <silent> ;cl :ColorToggle<cr>
map <silent> ;nt :NERDTreeToggle<cr>
