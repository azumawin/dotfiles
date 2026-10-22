" ~/.vimrc -- minimal port of my nvim config for machines without sudo/plugins
" No plugins required, works on plain vim 8/9.

set nocompatible
filetype plugin indent on
syntax enable

let mapleader = " "

" ---------------------------------------------------------------- options
set number
set relativenumber

" 4-space indentation, tab inserts spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent

set incsearch
set hlsearch
set scrolloff=10
set nowrap
set updatetime=1000

" vim defaults that nvim already has on
set backspace=indent,eol,start
set wildmenu
set showcmd
set laststatus=2
set display=lastline
set encoding=utf-8
set ttimeout
set ttimeoutlen=10
set nostartofline

" expose title so tmux can make use of it
set title
set titlestring=%t

" system clipboard only if this vim was built with it (likely not over ssh)
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
endif

" ripgrep as grep engine when available, plain recursive grep otherwise
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --glob\ '!.git'
  set grepformat=%f:%l:%c:%m
else
  " recursive from cwd so <leader>rg below behaves the same either way
  set grepprg=grep\ -nIHr\ --exclude-dir=.git\ $*\ .
endif

set background=dark
if has('termguicolors') && ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit')
  set termguicolors
endif
silent! colorscheme habamax

" ---------------------------------------------------------------- keymaps
" clear search highlight
nnoremap <silent> <Esc> :nohlsearch<CR>

" move cursor 15 lines
nnoremap <C-j> 15j
nnoremap <C-k> 15k
xnoremap <C-j> 15j
xnoremap <C-k> 15k

" buffer-wide find and replace for word under cursor
nnoremap <leader>rw :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>
nnoremap <leader>rW :%s/\<<C-r><C-W>\>/<C-r><C-W>/gc<Left><Left><Left>

" grep word under cursor from cwd into quickfix
nnoremap <leader>rg :silent grep! -F -- '<C-r><C-w>'<CR>
augroup grep_quickfix
  autocmd!
  autocmd QuickFixCmdPost grep,grepadd cwindow
augroup END

" replace across every file in the quickfix list
nnoremap <leader>re :cdo s///gc<Left><Left><Left><Left>

" quickfix
nnoremap <silent> <leader>. :call <SID>ToggleQuickfix()<CR>
nnoremap <leader>; :cnext<CR>
nnoremap <leader>' :cprev<CR>

" comment / uncomment visual selection
xnoremap <silent> gc :<C-u>call <SID>ToggleComment()<CR>

" diff current buffer against last write
nnoremap <silent> \ :call <SID>DiffOrig()<CR>

" ---------------------------------------------------------------- functions
function! s:QuickfixIsOpen() abort
  for i in range(1, winnr('$'))
    if getwinvar(i, '&buftype') ==# 'quickfix'
      return 1
    endif
  endfor
  return 0
endfunction

function! s:ToggleQuickfix() abort
  if s:QuickfixIsOpen()
    cclose
  else
    copen
  endif
endfunction

" comment leaders per filetype, extend as needed
let s:comment_strings = {
      \ 'sql': '--',
      \ }

function! s:ToggleComment() abort
  let cs = get(s:comment_strings, &filetype, '')
  if empty(cs)
    return
  endif
  let esc = escape(cs, '\.*$^~[]')
  let commented = 1
  let indent = -1
  for l in range(line("'<"), line("'>"))
    let text = getline(l)
    if text =~# '^\s*$'
      continue
    endif
    if text !~# '^\s*' . esc
      let commented = 0
    endif
    let width = strlen(matchstr(text, '^\s*'))
    if indent < 0 || width < indent
      let indent = width
    endif
  endfor
  if indent < 0
    return
  endif
  for l in range(line("'<"), line("'>"))
    let text = getline(l)
    if text =~# '^\s*$'
      continue
    endif
    if commented
      call setline(l, substitute(text, '^\(\s*\)' . esc . ' \?', '\1', ''))
    else
      call setline(l, strpart(text, 0, indent) . cs . ' ' . strpart(text, indent))
    endif
  endfor
endfunction

function! s:DiffOrig() abort
  if &diff
    diffoff | only
  else
    vert new | setlocal buftype=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
  endif
endfunction

" ---------------------------------------------------------------- highlight yank
if exists('##TextYankPost') && has('timers')
  function! s:ClearYankFlash(id, winid, timer) abort
    if win_getid() ==# a:winid
      silent! call matchdelete(a:id)
    endif
  endfunction

  function! s:FlashYank() abort
    if get(v:event, 'operator', '') !=# 'y'
      return
    endif
    let [_s, l1, c1, _o1] = getpos("'[")
    let [_e, l2, c2, _o2] = getpos("']")
    let pos = []
    if get(v:event, 'regtype', '') ==# 'v' && l1 ==# l2
      call add(pos, [l1, c1, c2 - c1 + 1])
    else
      for l in range(l1, l2)
        call add(pos, [l])
      endfor
    endif
    let id = matchaddpos('IncSearch', pos, 100)
    call timer_start(250, function('s:ClearYankFlash', [id, win_getid()]))
  endfunction

  augroup yank_flash
    autocmd!
    autocmd TextYankPost * call s:FlashYank()
  augroup END
endif
