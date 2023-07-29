set nocompatible
set nobackup
set nowritebackup
set noswapfile


" Use system clipboard
" http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
set clipboard+=unnamed

" Don't show intro
set shortmess+=I

" filetype detection
filetype plugin indent on


" code completion
set omnifunc=syntaxcomplete#Complete

" editor settings
set ruler   " ruler on
syntax enable " syntax checking
set history=100
set timeout timeoutlen=3000 ttimeoutlen=100
set showcmd "show incomplete commands
set incsearch "incremental searching (search as you type)
set smartcase "ignore case in search
set ignorecase "make sure any searches /searchPhrase doesn'T need the \c escape character
set backspace=indent,eol,start
set hlsearch " search highlighting on
setlocal spell spelllang=en_us "mostly writing in english these days...
set expandtab "convert tabs to spaces
set tabstop=4 "set tab size in spaces (manual indenting)
set shiftwidth=4 "the number of spaces inserted for a tab
set smartindent
set wildmenu "visual autocomplete
set showmatch "highlight a matching bracket when cursor is placed on start end character
set number "show linenumbers on the left
set autoread "autload files that have changed outside of vim
set lbr! "word wrap on

" status bar
if $TERM == "xterm"
   set laststatus=0
else
   set laststatus=2
   let g:airline_theme='solarized'
   let g:airline#extensions#whitespace#enabled = 0
endif

" set statusline to something useful
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)

"hide the toolbar
set guioptions-=T

" UTF encoding
set encoding=utf-8

" Highlight the current line
set cursorline

" Ensure Vim doesn't beep at you every time you make a mistype
set visualbell

" settings for :Explore

let g:netrw_liststyle=3 " use tree style viewer
let g:netrw_chgwin=2 " open the file in window #2 (great when using LExplore)
let g:netrw_browse_split=0 "open new files in current window


if $TERM == "xterm"
    colorscheme default 
else
    set background=dark
    colorscheme solarized
endif

