" Trying Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
"Plugin 'Valloric/YouCompleteMe'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" End Trying vundle

set colorcolumn=80

syntax on
set wildmenu
set wildmode=longest,list,full

" Ctrl j inserts a blank line below and ctrl k inserts above
nmap <C-k> O<Esc>j
nmap <C-j> o<Esc>k

" use 'space' to enter a single character in normal mode; similar to 'r'
nmap <Space> i_<Esc>r

"remember previous 100 commands
set history=100

" :W <caps-w> saves the file with permission denied error
command W w !sudo tee % > /dev/null

" to highlight the current line
set cursorline
hi CursorLine cterm=NONE,underline guibg=#F4F4F4

" Autocomplete the braces
"inoremap ( ()<Esc>:let leavechar=")"<CR>i
"inoremap [ []<Esc>:let leavechar="]"<CR>i

" For gluster test scripts set syn as bash
"autocmd BufNewFile,BufRead *.t set syn=sh

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Use spaces instead of tabs
set expandtab

" autoindent
"set autoindent

" set c style indentation
"set cindent

" set partial command
set showcmd

" show relative line number
set rnu

" show line number
set nu

" ignore the case sensitive search
set ignorecase

" Any uppercase in search string treated as case in-sensitive contrary to the
" above option
set smartcase

"always show the status line
set laststatus=2

" auto remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" cscope + vim settings
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
    set csverb
endif

nmap <C-_>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

"nmap <C-Space><C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-Space><C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Functions
" to view the diff in buffer to original file
" cmd :DiffSaved to see the diff
function! s:DiffWithSaved()
        let filetype=&ft
        diffthis
        vnew | r # | normal! 1Gdd
        diffthis
        exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Enable Tlist toggle with F8
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
" End Tlist options

"ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/tagbar.vim

"syntastic
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

" Switch betwen header and source files
nmap ,s :e %<.cc<CR>
nmap ,S :e %<.h<CR>
