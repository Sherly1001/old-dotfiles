" map functions

fu! DelCurBk()
    let l:bk1 = getline('.')[col('.') - 1]
    let l:bk2 = "])}\"'"[stridx("[({\"'", getline('.')[col('.') - 2])]
    return l:bk2 != '' && l:bk2 == l:bk1
endfu

" mapping key

ino jk                      <esc>
ino kj                      <esc>
ino <silent>    <c-a>       <esc>ggVG
ino <silent>    <c-v>       <esc>"+pa

ino             {           {}<left>
ino             {<cr>       {<cr>}<esc>O
ino <expr>      }           getline('.')[col('.')-1] == '}' ? '<right>' : '}'
ino             (           ()<left>
ino             (<cr>       (<cr>)<esc>O
ino <expr>      )           getline('.')[col('.')-1] == ')' ? '<right>' : ')'
ino             [           []<left>
ino             [<cr>       [<cr>]<esc>O
ino <expr>      ]           getline('.')[col('.')-1] == ']' ? '<right>' : ']'
ino <expr>      <bs>        DelCurBk() ? '<right><bs><bs>' : '<bs>'

ino <expr>      <tab>       pumvisible() ? '<down>' : '<tab>'
ino <expr>      <s-tab>     pumvisible() ? '<up>'   : '<s-tab>'

nn  Q                       :q!<cr>
nn  <silent>    <esc><esc>  :let @/ = ''<cr>
nn  <silent>    ;rl         :so $MYVIMRC<cr>
nn  <silent>    ;rc         :e $MYVIMRC<cr>
nn  <silent>    ;s          :e ~/.config/nvim/settings/settings.vim<cr>
nn  <silent>    ;m          :e ~/.config/nvim/settings/map.vim<cr>
nn  <silent>    ;id         :e ~/.config/nvim/settings/indent.vim<cr>
nn  <silent>    ;nt         :NERDTreeToggle<cr>
nn  ;no                     :NERDTree 

nn  <silent>    ;n<cr>      :tabe<cr>
nn  <silent>    <a-right>   :tabn<cr>
nn  <silent>    <a-left>    :tabp<cr>
nn  <silent>    ;t          :bel sp term://bash<cr>:resize 14<cr>
nn  <silent>    <c-j>       :res +5<cr>
nn  <silent>    <c-k>       :res -5<cr>
nn  <silent>    <c-h>       :vert res +5<cr>
nn  <silent>    <c-l>       :vert res -5<cr>

nn  <silent>    <s-k>       :call CocAction('doHover')<cr>

tno <silent>    <c-n>       <c-\><c-n>
tno <silent>    <c-h>       <c-w>
tno <silent>    <c-w>       <c-\><c-n><c-w>
