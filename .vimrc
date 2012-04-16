" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Disable vi compatibility
set nocompatible
" Use indentation of previous line.
set autoindent
" Use intelligent indentation for C
set smartindent
" Configure tab width and insert spaces instead of tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Wrap lines after 120 characters
set textwidth=120

" Turn syntax highlighting on
set t_Co=256
syntax on
colorscheme neverland2
" Turn line numbers on
set number
" Highlight matching braces
set showmatch
" Intelligent comments
" set comments=sl:*,mb:\ *,elx:\ */
" Stop the bell and make the screen flash instead
set visualbell

" Statusline
set laststatus=2
set statusline=%<%f\                    " Filename
set statusline+=%w%h%m%r                " Options
set statusline+=\ [%{&ff}/%Y]           " File type
set statusline+=\ [%{getcwd()}]         " Current directory
set statusline+=\ [A=\%03.3b/H=\%2.2B]  " ASCII/Hex value of char
set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nac info

" Random
set backspace=2
set cursorline
hi cursorline guibg=#333333
hi CursorColumn guibg=#333333

set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set showcmd
set foldmethod=indent
set foldlevel=99
set nomodeline
filetype plugin on

" C omnicompletion
set ofu=syntaxcomplete#Complete

" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteScope = 1
" Automatically open the menu
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
"-----------------"

"---KEYBINDINGS!!!---"
" Compile C code "
nmap <C-c> :call CompileRunCC() <CR>
inoremap <C-c> <esc>:call CompileRunCC() <CR>
" Fold code and/or comments "
noremap <silent> <C-d> za
inoremap <silent> <C-d> <esc>za<down>i<up>
" Rebind esc to ctrl+e
inoremap <silent> <C-e> <esc>
" Completion etc
"imap <silent> <buffer> . .<C-x><C-o>

"---FUNCTIONS!!!---"
func! CompileRunCC()
    exec "w"
    exec "!clear;cc % -o %<; echo Executing %<; echo ; ./%<"
endfunc

func! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d ff=unix :",
        \ &tabstop, &shiftwidth, &textwidth)
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunc
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
