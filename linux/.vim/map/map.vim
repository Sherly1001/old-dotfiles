
" mapping key

no <silent> ;ic :set ic!<cr>
no <silent> ;hl :set hls!<cr>
nn <silent> <esc><esc> :nohls<cr>

no <silent> Q :q!<cr>
vn <bs> x
ino kk <esc>
nn <space> <pagedown>
nn <s-space> <pageup>
ino <silent> <c-a> <esc>ggVG
no <silent> <c-a> ggVG
no <silent> <c-x> "+x
no <silent> <c-c> "+y
ino <silent> <c-v> <esc>"+gpa
no <silent> ;n<cr> :tabnew<cr>
no <silent> <c-t> :bro conf tabnew<cr>
no <silent> <c-left> :tabp<cr>
no <silent> <c-right> :tabn<cr>
no <silent> <c-j> :res +5<cr>
no <silent> <c-k> :res -5<cr>
no <silent> <c-h> :vert res -5<cr>
no <silent> <c-l> :vert res +5<cr>
no <silent> ;rc :e ~/.vimrc<cr>
no <silent> ;s :e ~/.vim/settings/settings.vim<cr>
no <silent> ;ind :e ~/.vim/indent/indent.vim<cr>
no <silent> ;m :e ~/.vim/map/map.vim<cr>
no <silent> ;rl :so ~/.vimrc<cr>
no <silent> ;t :bel ter ++close<cr>
tno <silent> <c-n> <c-\><c-n>

no <silent> ;cl :ColorToggle<cr>
no <silent> ;nt :NERDTreeToggle<cr>
