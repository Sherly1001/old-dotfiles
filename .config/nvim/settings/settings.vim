set number
set relativenumber
set ignorecase
set wildignorecase
set smartcase
set cursorline
set noundofile
set nobackup
set noswapfile
set backspace=2
set belloff=all
set mouse=a
set timeout timeoutlen=250
set updatetime=100
colo onedark

set list
set listchars=tab:>-,trail:.
set fillchars=vert:\ ,fold:\ 
set statusline=%f%=%{funcs#coc_status()}\ %y%r\ %-14(%3c-%l/%L%)%P
set showtabline=2
set tabline=%!funcs#tabline()

if exists('g:neovide')
    set guifont=Consolas:h9
    let g:neovide_cursor_antialiasing = v:true
    let g:neovide_cursor_animation_length = 0.13
    let g:neovide_cursor_vfx_opacity = 500.0
    let g:neovide_cursor_vfx_mode = 'railgun'
    let g:neovide_cursor_vfx_particle_density = 10.0
endif

let g:netrw_liststyle = 3
let g:netrw_browser_split = 4

let g:NERDTreeMinimalUI         =   1
let g:NERDTreeShowHidden        =   1
let g:NERDTreeShowLineNumbers   =   1
let g:NERDTreeWinSize           =   24
let g:NERDTreeStatusline        =   "%{''}"

let g:rustfmt_options = "--edition 2021"

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1

let g:AutoPairsMapCh = 0

" let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_multiple_files = 't'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': [],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

if exists('*glaive#Install') && exists(':Glaive')
    call glaive#Install()
    Glaive codefmt rustfmt_options=`['--edition', '2021']`
endif

aug dynamic_smartcase
    au!
    au CmdLineEnter : set nosmartcase
    au CmdLineLeave : set smartcase
aug end

aug leave_cursor
    au!
    au vimleave * sil! set gcr=a:hor20-blinkwait175-blinkoff150-blinkon175
aug end

aug terminal_mode
    au!
    au TermOpen * setlocal statusline=%{b:term_title} | set nornu | set nonu
    au BufEnter term://* startinsert
    au TermClose * :q
aug end

aug check_file_changed
    au!
    au FocusGained * :checktime
aug end
