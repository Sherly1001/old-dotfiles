func! Tabline()
  let s = '%#TabLine#'
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '')
    let s .= (bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]')
    let s .= (bufmodified ? ' [+]' : '')

    let s .= '%#TabLine# '
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunc

set nu
set rnu
set ic
set wic
set scs
set cul
set noudf
set nobk
set bs=2
set bo=all
set mouse=a
colo monokai_pro
set to tm=250

set list
set lcs=tab:>-,trail:.
set fcs=vert:\ 
set stl=%F%=%{coc#status()}\ %y%r\ %-14(%3c-%l/%L%)%P
set stal=2
set tal=%!Tabline()

let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize   = 24
let g:NERDTreeStatusline="%{''}"

aug dynamic_smartcase
    au!
    au CmdLineEnter : set nosmartcase
    au CmdLineLeave : set smartcase
aug end

aug leave_cursor
    au!
    au vimleave * sil! set gcr=a:hor20-blinkwait175-blinkoff150-blinkon175
aug end

"aug nerdtree_open
"    au!
"    au VimEnter * sil! NERDTree | winc l
"    au TabEnter * sil! if winnr('$') < 2 | NERDTreeMirror |
"        \ winc l | endif
"    au BufEnter NERD_tree_* sil! if winnr('$') < 2
"        \ && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"        \ if tabpagenr('$') < 2 | set gcr=a:hor20-blinkwait175-blinkoff150-blinkon175 | endif |
"        \ q! | endif
"aug end

aug terminal_mode
    au!
    au TermOpen * setlocal statusline=%{b:term_title} | set nornu | set nonu
    au BufEnter term://* call nvim_input('i')
    au TermClose * call nvim_input('<cr>')
aug end
