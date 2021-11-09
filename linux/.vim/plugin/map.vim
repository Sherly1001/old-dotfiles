" map functions

fu! DelCurBk()
    let l:bk1 = getline('.')[col('.') - 1]
    let l:bk2 = "])}\"'"[stridx("[({\"'", getline('.')[col('.') - 2])]
    if l:bk2 != '' && l:bk2 == l:bk1
        return "\<right>\<bs>\<bs>"
    else
        return "\<bs>"
    endif
endfu

" mapping key

ino jk          <esc>
ino kj          <esc>
ino <silent>    <c-a>       <esc>ggVG
ino <silent>    <c-v>       <esc>"+pa

ino             {           {}<left>
ino             {<cr>       {<cr>}<esc>O
ino <expr>      }           getline('.')[col('.')-1] == "}" ? "\<right>" : "}"
ino             (           ()<left>
ino             (<cr>       (<cr>)<esc>O
ino <expr>      )           getline('.')[col('.')-1] == ")" ? "\<right>" : ")"
ino             [           []<left>
ino             [<cr>       [<cr>]<esc>O
ino <expr>      ]           getline('.')[col('.')-1] == "]" ? "\<right>" : "]"
ino <expr>      "           getline('.')[col('.')-1] == "\"" ? "\<right>" : "\"\"\<left>"
ino <expr>      '           getline('.')[col('.')-1] == "\'" ? "\<right>" : "\'\'\<left>"
ino <expr>      <bs>        DelCurBk()
ino <expr>      <s-cr>      getline('.') =~ ';$' ? "\<esc>$a" : "\<esc>$a;"

nn  <silent>    <esc><esc>  :let @/ = ''<cr>
nn  <space>     <pagedown>
nn  <s-space>   <pageup>

nn  <silent>    Q           :q!<cr>
nn  <silent>    ;hl         :set hls!<cr>
nn  <silent>    ;ic         :set ic!<cr>
nn  <silent>    ;n<cr>      :tabe<cr>
nn  <silent>    ;rl         :so ~/.vimrc<cr>
nn  <silent>    ;rc         :e ~/.vimrc<cr>
nn  <silent>    ;s          :e ~/.vim/plugin/settings.vim<cr>
nn  <silent>    ;ind        :e ~/.vim/plugin/indent.vim<cr>
nn  <silent>    ;m          :e ~/.vim/plugin/map.vim<cr>
nn  <silent>    ;t          :bel ter ++close ++rows=15<cr>
nn  <silent>    ;rt         :vert bel ter ++close<cr>
nn  <silent>    ;cl         :ColorToggle<cr>
nn  <silent>    ;nt         :NERDTreeToggle<cr>
nn  <silent>    ;nm         :NERDTreeMirror<cr>
nn  ;no         :NERDTree 

no  <silent>    <c-a>       ggVG
no  <silent>    <c-c>       "+y
no  <silent>    <c-x>       "+x
no  <silent>    <a-left>    :tabp<cr>
no  <silent>    <a-right>   :tabn<cr>
no  <silent>    <c-s-left>  :tabm-1<cr>
no  <silent>    <c-s-right> :tabm+1<cr>
no  <silent>    <c-j>       :res +5<cr>
no  <silent>    <c-k>       :res -5<cr>
no  <silent>    <c-l>       :vert res +5<cr>
no  <silent>    <c-h>       :vert res -5<cr>
no  <silent>    <c-t>       :bro conf tabe<cr>

tno <silent>    <c-n>       <c-\><c-n>
tno <silent>    <c-s-v>     <c-w>"+p

vn  <bs>        x
