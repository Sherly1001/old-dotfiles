" vi: sw=2 ts=2
" settings functions

fu! s:evaluate_tabline(tabline)
  let l:tabline = a:tabline
  let l:tabline = substitute(l:tabline, '%{\([^}]\+\)}', '\=eval(submatch(1))', 'g')
  let l:tabline = substitute(l:tabline, '%#[^#]\+#', '', 'g')
  let l:tabline = substitute(l:tabline, '%(\([^)]\+\)%)', '\1', 'g')
  let l:tabline = substitute(l:tabline, '%\d*[TX]', '', 'g')
  let l:tabline = substitute(l:tabline, '%=', '', 'g')
  let l:tabline = substitute(l:tabline, '%\d*\*', '', 'g')
  if has('tablineat')
    let l:tabline = substitute(l:tabline, '%@[^@]\+@', '', 'g')
  endif
  return l:tabline
endfu

fu! funcs#tabline()
  let l:numtab = tabpagenr('$')
  let l:currtab = tabpagenr()
  let l:cols = &columns
  let l:tabs = []
  let l:pertab = l:numtab > 1 ? l:currtab . '/' . l:numtab : ''

  for i in range(l:numtab)
    let l:tab = i + 1
    let l:winnr = tabpagewinnr(l:tab)
    let l:buflist = tabpagebuflist(l:tab)
    let l:bufnr = l:buflist[l:winnr - 1]
    let l:bufname = bufname(l:bufnr)
    let l:bufmodified = getbufvar(l:bufnr, "&mod")

    let l:filename = l:bufname != '' ? fnamemodify(l:bufname, ':t') : '[No Name]'
    if len(l:filename) > 15
      let l:filename = l:filename[:10] . '..' . fnamemodify(l:bufname, ':e')
    endif

    let l:tabname = l:tab == l:currtab ? '%#TabLineSel#' : '%#TabLine#'
    let l:tabname .= '%' . l:tab . 'T '
    let l:tabname .= l:filename
    let l:tabname .= l:bufmodified ? ' •' : ''
    let l:tabname .= ' %T'

    call add(l:tabs, l:tabname)
  endfor

  let l:tabline = l:tabs[l:currtab - 1]
  let l:is_left = 1
  let l:left = l:currtab - 2
  let l:right = l:currtab

  while l:left >= 0 || l:right < l:numtab
    let l:next = l:tabline

    if l:is_left
      if l:left >= 0
        let l:next = tabs[l:left] . l:tabline
        let l:left -= 1
      endif
    else
      if l:right < l:numtab
        let l:next = l:tabline . tabs[l:right]
        let l:right += 1
      endif
    endif

    let l:ev = s:evaluate_tabline(l:next) . l:pertab
    if len(l:ev) > cols
      break
    else
      let l:tabline = l:next
    endif

    let l:is_left = !l:is_left
  endwhile

  return '%#TabLineFill#' . l:tabline . '%#TabLineFill#' . '%=' . l:pertab
endfu


" map functions

let s:last_buffs_cache = '~/.cache/nvim/last_buffs'
try
  let s:last_buffs = readfile(expand(s:last_buffs_cache))
catch
  let s:last_buffs = []
endtry

fu! funcs#close_buff()
  let l:is_nerdtree = matchstr(buffer_name(), '^NERD_tree_') != ''
  if l:is_nerdtree | q | return | endif
  if buffer_name() != ''
    call add(s:last_buffs, expand('%:p'))
    call writefile(s:last_buffs, expand(s:last_buffs_cache))
  endif
  q!
endfu

fu! funcs#open_last_buff()
  let l:buffer_name = get(s:last_buffs, -1, '')
  if l:buffer_name == '' | return | endif
  call remove(s:last_buffs, -1)
  call writefile(s:last_buffs, expand(s:last_buffs_cache))
  exec 'tabe ' . l:buffer_name
endfu
