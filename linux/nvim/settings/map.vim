" map functions

let s:last_buffs_cache = '~/.cache/nvim/last_buffs'
try
    let s:last_buffs = readfile(expand(s:last_buffs_cache))
catch
    let s:last_buffs = []
endtry

fu! CloseBuff()
    let l:is_nerdtree = matchstr(buffer_name(), '^NERD_tree_') != ''
    if l:is_nerdtree | q | return | endif
    if buffer_name() != ''
        call add(s:last_buffs, expand('%:p'))
        call writefile(s:last_buffs, expand(s:last_buffs_cache))
    endif
    q!
endfu

fu! OpenLastBuff()
    let l:buffer_name = get(s:last_buffs, -1, '')
    if l:buffer_name == '' | return | endif
    call remove(s:last_buffs, -1)
    call writefile(s:last_buffs, expand(s:last_buffs_cache))
    exec 'tabe ' . l:buffer_name
endfu

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

nn  <silent>    Q           :call CloseBuff()<cr>
nn  <silent>    T           :call OpenLastBuff()<cr>
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
nn  <silent>    <a-h>       :tabn<cr>
nn  <silent>    <a-l>       :tabp<cr>
nn  <silent>    <a-s-h>     :tabm -1<cr>
nn  <silent>    <a-s-l>     :tabm +1<cr>

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

nn  <silent>    <s-k>       :call CocAction('doHover')<cr>
" nn  <silent>    <c-f>       :FormatCode<cr>
nn  <expr>      <silent>    <c-f>
    \ index(['javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json', 'vue', 'html', 'css', 'scss'], &ft) < 0
    \ ? ':FormatCode<cr>'
    \ : ':CocCommand prettier.formatFile<cr>'

tno <silent>    <c-n>       <c-\><c-n>
tno <silent>    <c-h>       <c-w>
tno <silent>    <c-w>       <c-\><c-n><c-w>

vno <silent>    <c-c>       "+y
vno <silent>    <c-x>       "+x
