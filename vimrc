source /etc/vimrc

set colorcolumn=80


" Ctrl j inserts a blank line below and ctrl k inserts above
nmap <C-k> O<Esc>j
nmap <C-j> o<Esc>k

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" use 'space' to enter a single character in normal mode; similar to 'r'
nmap <Space> i_<Esc>r

"remember previous 100 commands
set history=1000

" :W <caps-w> saves the file with permission denied error
command W w !sudo tee % > /dev/null

" to highlight the current line
set cursorline
hi CursorLine cterm=NONE,underline guibg=#F4F4F4

" Highlight search results
set hlsearch

" Bash like autocompletion
set wildmode=longest,list,full
set wildmenu

" Makes search act like search in modern browsers
set incsearch

" Stop the search at end of file.
"set nowrapscan

" Use spaces instead of tabs
set expandtab

" autoindent
set autoindent

" set c style indentation
set cindent

" set partial command
set showcmd

" show relative line number
set rnu

" show line number
set nu

" ignore the case sensitive search
set ignorecase

set shiftwidth=2
set softtabstop=2

" Any uppercase in search string treated as case in-sensitive contrary to the
" above option
set smartcase

"always show the status line
set laststatus=2

" auto remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Functions to view the diff in buffer to original file
" cmd :DiffSaved to see the diff
function! s:DiffWithSaved()
       let filetype=&ft
       diffthis
       vnew | r # | normal! 1Gdd
       diffthis
       exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

colorscheme darkblue

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'sjl/gundo.vim'
Plugin 'rking/ag.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'PProvost/vim-ps1'
"Plugin 'scrooloose/nerdtree'
Plugin 'congma/pylint.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'artur-shaik/vim-javacomplete2'
"Plugin 'xolox/vim-easytags'


let g:jedi#use_tabs_not_buffers = 1

filetype plugin indent on
let mapleader="," " leader is comma
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>
autocmd FileType tagbar setlocal nocursorline nocursorcolumn

" Switch betwen header and source files
nmap <leader>c :A<CR>
nmap <leader>h :A<CR>

" Fast saving
nmap <leader>w :w<cr>

"nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>f :GFiles<cr>
nmap <leader>F :Files<cr>

vnoremap // y/<C-R>"<CR>

" FZF to search the tags file.
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R ')
  endif

  call fzf#run({
        \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
        \            '| grep -v -a ^!',
        \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
        \ 'down':    '40%',
        \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

" FZF to search tags in current file.
function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
        \ 'ctags -f - --sort=no --excmd=number --language-force=auto %s',
        \ expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
          \ 'source':  s:btags_source(),
          \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
          \ 'down':    '40%',
          \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()
nmap <leader>s :Tags<cr>
nmap <leader>d :BTags<cr>
nmap <leader>l :BLines<cr>

nmap <leader>j gj
nmap <leader>k gk
