" map functions

fu! IsBks()
    let l:bk1 = getline('.')[col('.') - 1]
    let l:bk2 = "])}\"'"[stridx("[({\"'", getline('.')[col('.') - 2])]
    return l:bk2 != '' && l:bk2 == l:bk1
endfu

fu! IsChar(c)
    return a:c == getline('.')[col('.') - 1]
endfu

" mapping key

ino jk                      <esc>
ino kj                      <esc>

ino             {           {}<left>
ino             (           ()<left>
ino             [           []<left>
ino <expr>      }           IsChar('}') ? '<right>' : '}'
ino <expr>      )           IsChar(')') ? '<right>' : ')'
ino <expr>      ]           IsChar(']') ? '<right>' : ']'
ino <expr>      <bs>        IsBks() ? '<bs><del>'  : '<bs>'
ino <expr>      <cr>        IsBks() ? '<cr><esc>O' : '<cr>'

ino <expr>      <tab>       pumvisible() ? '<down>' : '<tab>'
ino <expr>      <s-tab>     pumvisible() ? '<up>'   : '<s-tab>'

nn  <expr>      Q           matchstr(buffer_name(), '^NERD_tree_') != '' ? ':q<cr>' : ':q!<cr>'
nn  <silent>    <esc><esc>  :let @/ = ''<cr>
nn  <silent>    ;rl         :so $MYVIMRC<cr>
nn  <silent>    ;rc         :e $MYVIMRC<cr>
nn  <silent>    ;s          :e ~/.config/nvim/settings/settings.vim<cr>
nn  <silent>    ;m          :e ~/.config/nvim/settings/map.vim<cr>
nn  <silent>    ;id         :e ~/.config/nvim/settings/indent.vim<cr>
nn  <silent>    ;nt         :NERDTreeToggle<cr>
nn  ;no                     :NERDTree 

nn  <silent>    <c-t>       :tabe<cr>
nn  <silent>    <c-n>       :tabe .<cr>
nn  <silent>    <a-right>   :tabn<cr>
nn  <silent>    <a-left>    :tabp<cr>
nn  <silent>    <a-s-left>  :tabm -1<cr>
nn  <silent>    <a-s-right> :tabm +1<cr>
nn  <silent>    ;t          :bel sp term://bash<cr>:resize 14<cr>
nn  <silent>    <c-j>       :res +5<cr>
nn  <silent>    <c-k>       :res -5<cr>
nn  <silent>    <c-h>       :vert res +5<cr>
nn  <silent>    <c-l>       :vert res -5<cr>

nn  <silent>    <s-k>       :call CocAction('doHover')<cr>
nn  <silent>    <c-f>       :CocCommand prettier.formatFile<cr>

tno <silent>    <c-n>       <c-\><c-n>
tno <silent>    <c-h>       <c-w>
tno <silent>    <c-w>       <c-\><c-n><c-w>
