ino jk          <esc>
ino kj          <esc>
ino <c-h>       <left>
ino <c-j>       <down>
ino <c-k>       <up>
ino <c-l>       <right>

ino <expr>      <tab>       exists('*coc#pum#visible') && coc#pum#visible()
                            \ ? coc#pum#next(0) : '<tab>'
ino <expr>      <s-tab>     exists('*coc#pum#visible') && coc#pum#visible()
                            \ ? coc#pum#prev(0) : '<s-tab>'
ino <expr>      <cr>        exists('*coc#pum#visible') && coc#pum#visible()
                            \ ? coc#pum#confirm() : '<cr>'

nn  <silent>    Q           :call funcs#close_buff()<cr>
nn  <silent>    T           :call funcs#open_last_buff()<cr>
nn  <silent>    <esc><esc>  :let @/ = ''<cr>
nn  <silent>    ;rl         :so $MYVIMRC<cr>
nn  <silent>    ;rc         :e $MYVIMRC<cr>
nn  <silent>    ;s          :e ~/.config/nvim/settings/settings.vim<cr>
nn  <silent>    ;m          :e ~/.config/nvim/settings/map.vim<cr>
nn  <silent>    ;id         :e ~/.config/nvim/settings/indent.vim<cr>
nn  <expr>      ;vi
    \   &keymap == '' ? ':set keymap=vietnamese-vni<cr>' : ':set keymap=<cr>'
nn  <silent>    ;nt         :NERDTreeToggle<cr>
nn  ;no                     :NERDTree 

nn  <silent>    <c-t>       :tabe<cr>
nn  <silent>    <c-n>       :tabe .<cr>
nn  <silent>    <a-h>       :tabp<cr>
nn  <silent>    <a-l>       :tabn<cr>
nn  <silent>    <a-left>    :tabp<cr>
nn  <silent>    <a-right>   :tabn<cr>
nn  <silent>    <a-s-h>     :tabm -1<cr>
nn  <silent>    <a-s-l>     :tabm +1<cr>
nn  <silent>    <a-s-left>  :tabm -1<cr>
nn  <silent>    <a-s-right> :tabm +1<cr>

for i in range(1, 9)
    let map="nn  <silent>    <a-" . i . ">   :tabn " . i . "<cr>"
    exec map
endfor

nn  <silent>    ;tt         :bel sp term://bash<cr>:resize 14<cr>
nn  <silent>    ;tv         :bel vs term://bash<cr>
nn  <silent>    <c-j>       :res +5<cr>
nn  <silent>    <c-k>       :res -5<cr>
nn  <silent>    <c-h>       :vert res +5<cr>
nn  <silent>    <c-l>       :vert res -5<cr>

nn  <silent>    ;cl         :ColorToggle<cr>

nn  <silent>    ]g          <plug>(coc-diagnostic-next)
nn  <silent>    [g          <plug>(coc-diagnostic-prev)

nn  <silent>    gf          :GitGutterFold<cr>
nn              gl          :call gitblame#echo()<cr>
nn  <silent>    <s-k>       :call CocAction('doHover')<cr>
nn  <expr>      <silent>    <c-f>
    \ index(['javascript', 'typescript',
    \        'javascriptreact', 'typescriptreact',
    \        'json', 'vue', 'html', 'css', 'scss'], &ft) < 0
    \ ? ':FormatCode<cr>'
    \ : ':CocCommand prettier.formatFile<cr>'

tno <silent>    <c-n>       <c-\><c-n>
tno <silent>    <c-h>       <c-w>
tno <silent>    <c-w>       <c-\><c-n><c-w>

vno <silent>    <c-c>       "+y
vno <silent>    <c-x>       "+x
