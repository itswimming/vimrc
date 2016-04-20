set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$vim/vimfiles/bundle/Vundle.vim
let path='$vim/vimfiles/bundle'
call vundle#begin(path)
Plugin 'gmarik/Vundle.vim'

""""""""""
"spf13 setup start
""""""""""
Plugin 'ctrlp.vim'
Plugin 'surround.vim'
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'neocomplcache'
Plugin 'Syntastic'
Plugin 'Tagbar'
Plugin 'EasyMotion'
"Plugin 'taglist-plus'
Plugin 'taglist.vim'
Plugin 'Tabular'
"Plugin 'Brace-Complete-for-CCpp'
"Plugin 'CmdlineComplete'
"Plugin 'CompleteHelper'
"Plugin 'IComplete'
"Plugin 'apt-complete.vim'
"Plugin 'code_complete-new-update'
"Plugin 'OmniCppComplete'
Plugin 'SingleCompile'
"Plugin 'SnippetComplete'
"Plugin 'StringComplete'
Plugin 'The-NERD-tree'
"Plugin 'win-manager-Improved'
Plugin 'winmanager'
Plugin 'The-NERD-Commenter'
"Plugin 'popup_it'
Plugin 'bufexplorer.zip'
"Plugin 'AutoFold.vim'
"Plugin 'UltiSnips'
Plugin 'AutoClose'
Plugin 'vimomni'
Plugin 'ervandew/supertab'
Plugin 'xptemplate'
Plugin 'mbbill/fencview'
Plugin 'a.vim'
Plugin 'yonchu/accelerated-smooth-scroll'
Plugin 'LargeFile'
Plugin 'tacahiroy/ctrlp-funky'
""""""""""
"spf13 setup end
""""""""""

call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My own basic config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Platform
function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

set ruler		
set showcmd		
set incsearch		
set showmatch

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype plugin indent on

  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set shiftwidth=4
set softtabstop=4
set noexpandtab
if has("win32")
	au GUIEnter * simalt ~x
endif


"set guifont=courier_new:h14
"set guifont=Microsoft_YaHei_Mono:h14
"set guifont=YaHei_Consolas_Hybrid:h14
set guifont=Source_Code_Pro:h14
set smarttab
set nobackup
syntax enable on
set linespace=4
set autoindent
set smartindent
"filetype plugin indent on
filetype plugin on
set nu
"set wildmode
set wildmenu
set nofen
" set foldenable

"Set mapleader
let mapleader = ","

set cmdheight=2
nnoremap <leader>wj :wincmd j<cr>
nnoremap <leader>wk :wincmd k<cr>
nnoremap <leader>wh :wincmd h<cr>
nnoremap <leader>wl :wincmd l<cr>
nnoremap <leader>we :new .<cr>
nnoremap <leader>ve :vnew .<cr>

"Fast edit vimrc
if MySys() == 'linux'
    map <silent> <leader>ss :source ~/.vimrc<cr>
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
	map <silent> <leader>ss :source $MYVIMRC<cr>
	map <silent> <leader>ee :call SwitchToBuf($MYVIMRC)<cr>
   autocmd! bufwritepost $MYVIMRC source $MYVIMRC
endif

set colorcolumn=80

set bsdir=buffer
set autochdir		"need this feature be compiled with"
"autocmd BufEnter * lcd %:p:h
set tags=.tags,./../tags,./**/tags
set fileencodings=ucs-bom,utf8,chinese,taiwan,japan,korea,default,ansi
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"winmanager settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "FileExplorer,BufExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr>

runtime macros/matchit.vim
"set foldenable              " 开始折叠
"set foldmethod=syntax       " 设置语法折叠
"set foldcolumn=0            " 设置折叠区域的宽度
"setlocal foldlevel=1        " 设置折叠层数为
"set foldlevelstart=99       " 打开文件是默认不折叠代码

"set foldclose=all          " 设置为自动关闭折叠                
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " 用空格键来开关折叠
autocmd filetype inc,lpr,pp:set filetype=pascal
"autocmd filetype pascal,pp:setlocal autoindent
au BufRead,BufNewFile *.pp,*.lpr,*.inc		set filetype=pascal
"let g:Tlist_File_Fold_Auto_Close=1 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""" to compile easily
"if lowercase(%:e) in ['pas', 'pp', 'lpr'] 
	"compiler fpc
	"nmap <F9> :make<cr>
"endif


"nmap <F9> :SingleCompile<cr>
nmap <F9> :make<cr>
nmap <F10> :SingleCompileRun<cr>
"call SingleCompile#ChooseCompiler('pascal', 'fpc')
map <F4> :x<cr>
set laststatus=2
set statusline=%<%t\ %y[%{&ff}][%{&fenc}]%m%r%=%-14.(%l,%c%V%)\ %P
" let @"=""
set shortmess+=I
"let loaded_nerd_tree=1
set ignorecase smartcase
let g:tagbar_left = 1
nnoremap <silent> <F9> :TagbarToggle<CR>
set guioptions-=T
set guioptions-=m
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
let g:SuperTabClosePreviewOnPopupClose = 1
map <F12> :so %<cr>
"let mq4tags="d:\work\mt4\mt4src\MQL4\tags"
let g:alternateExtensions_CPP = "inc,h,H,HPP,hpp,mqh"
augroup mql
    au!
    "autocmd FileType *.mqh,*.mq4,*.mq5 set ft=cpp
    autocmd BufNewFile,BufEnter,BufReadPost *.mqh,*.mq4 set ft=cpp
    autocmd BufNewFile,BufEnter,BufRead *.mqh,*.mq4 set tags+=d:/work/mt4/mt4src/MQL4/tags
augroup END

map <c-s> :update<cr>
set cursorcolumn cursorline
nnoremap <Leader>f :CtrlPFunky<Cr>
" Initialise list by a word under cursor
nnoremap <Leader>u :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
