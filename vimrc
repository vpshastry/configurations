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
Plugin 'mru.vim'
Plugin 'airblade/vim-gitgutter'
let g:jedi#use_tabs_not_buffers = 1

filetype plugin indent on
let mapleader="," " leader is comma
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>n gt
nnoremap <leader>N gT
" Switch betwen header and source files
nmap <leader>s :e %<.cc<CR>
nmap <leader>S :e %<.h<CR>
" Fast saving
nmap <leader>w :w<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>f :CtrlP<cr>
vnoremap // y/<C-R>"<CR>
