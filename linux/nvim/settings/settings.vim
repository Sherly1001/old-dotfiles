func! Tabline()
  let s = '%#TabLineFill#'
  let numtab = tabpagenr('$')

  for i in range(numtab)
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    let s .= bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]'
    let s .= bufmodified ? ' [+]' : ''
    let s .= '%T'

    let s .= '%#TabLineFill#'
    let s .= tab < numtab ? ' ' : ''
  endfor

  return s
endfunc

set number
set relativenumber
set ignorecase
set wildignorecase
set smartcase
set cursorline
set noundofile
set nobackup
set backspace=2
set belloff=all
set mouse=a
set timeout timeoutlen=250
colo monokai_pro

set list
set listchars=tab:>-,trail:.
set fillchars=vert:\ ,fold:\ 
set statusline=%F%=%{coc#status()}\ %y%r\ %-14(%3c-%l/%L%)%P
set showtabline=2
set tabline=%!Tabline()

if exists('g:neovide')
    set guifont=Consolas:h9
endif

let g:netrw_liststyle = 3
let g:netrw_browser_split = 4

let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize   = 24
let g:NERDTreeStatusline="%{''}"
let g:NERDTreeShowHidden= 1

let g:rustfmt_options = "--edition 2021"

call glaive#Install()
Glaive codefmt rustfmt_options=`['--edition', '2021']`

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
