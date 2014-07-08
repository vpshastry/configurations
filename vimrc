set colorcolumn=80

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
inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i

" For gluster test scripts set syn as bash
autocmd BufNewFile,BufRead *.t set syn=sh

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

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
