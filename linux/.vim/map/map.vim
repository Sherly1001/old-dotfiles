" map functions

fu! DelCurBk()
    let bk1 = getline('.')[col('.') - 1]
    let bk2 = "])}\"'"[stridx("[({\"'", getline('.')[col('.') - 2])]
    if bk2 != '' && bk2 == bk1
        return "\<right>\<bs>\<bs>"
    else
        return "\<bs>"
    endif
endfu

" mapping key

ino kk          <esc>
ino <silent>    <c-a>       <esc>ggVG
ino <silent>    <c-v>       <esc>"+gpa

ino             {           {}<left>
ino             {<cr>       {<cr>}<esc>O
ino <expr>      }           getline('.')[col('.')-1] == "}" ? "\<right>" : "}"
ino             (           ()<left>
ino <expr>      )           getline('.')[col('.')-1] == ")" ? "\<right>" : ")"
ino             [           []<left>
ino <expr>      ]           getline('.')[col('.')-1] == "]" ? "\<right>" : "]"
ino <expr>      "           getline('.')[col('.')-1] == "\"" ? "\<right>" : "\"\"\<left>"
ino <expr>      '           getline('.')[col('.')-1] == "\'" ? "\<right>" : "\'\'\<left>"
ino <expr>      <bs>        DelCurBk()
ino <expr>      <s-cr>      getline('.') =~ ';$' ? "\<esc>$a" : "\<esc>$a;"

nn  <silent>    <esc><esc>  :nohls<cr>
nn  <space>     <pagedown>
nn  <s-space>   <pageup>

no  <silent>    Q           :q!<cr>
no  <silent>    ;hl         :set hls!<cr>
no  <silent>    ;ic         :set ic!<cr>
no  <silent>    ;n<cr>      :tabe<cr>
no  <silent>    ;rl         :so ~/.vimrc<cr>
no  <silent>    ;rc         :e ~/.vimrc<cr>
no  <silent>    ;s          :e ~/.vim/settings/settings.vim<cr>
no  <silent>    ;ind        :e ~/.vim/indent/indent.vim<cr>
no  <silent>    ;m          :e ~/.vim/map/map.vim<cr>
no  <silent>    ;t          :bel ter ++close<cr>
no  <silent>    ;cl         :ColorToggle<cr>
no  <silent>    ;nt         :NERDTreeToggle<cr>
no  <silent>    ;nm         :NERDTreeMirror<cr>

no  <silent>    <c-a>       ggVG
no  <silent>    <c-c>       "+y
no  <silent>    <c-x>       "+x
no  <silent>    <c-left>    <c-w>h
no  <silent>    <c-right>   <c-w>l
no  <silent>    <c-up>      <c-w>k
no  <silent>    <c-down>    <c-w>j
no  <silent>    <c-j>       :res +5<cr>
no  <silent>    <c-k>       :res -5<cr>
no  <silent>    <c-l>       :vert res +5<cr>
no  <silent>    <c-h>       :vert res -5<cr>
no  <silent>    <c-t>       :bro conf tabe<cr>

tno <silent>    <c-left>    <c-w>h
tno <silent>    <c-right>   <c-w>l
tno <silent>    <c-up>      <c-w>k
tno <silent>    <c-down>    <c-w>j
tno <silent>    <c-n>       <c-\><c-n>

vn  <bs>        x
