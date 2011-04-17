" No vi compatibility. This must be first, because it changes other options as
" side effect
set nocompatible

set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

" Bundles:
Bundle "Wombat"
Bundle "scrooloose/nerdtree"
Bundle "snipMate"
Bundle "python.vim"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-repeat"
Bundle "tComment"
Bundle "Indent-Guides"
Bundle "fholgado/minibufexpl.vim"
Bundle "Lokaltog/vim-easymotion"
"Bundle "L9"
"Bundle "FuzzyFinder"
"Bundle "rails.vim"
"Bundle "ack.vim"
"Bundle "git://git.wincent.com/command-t.git"
" ...


" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Hide buffers instead of closing them
set hidden

"set nowrap         " don't wrap lines
set tabstop=4       " a tab is four spaces wide
set backspace=indent,eol,start  " allow backspacing over everything in insert
                                "   mode
set autoindent      " always set autoindenting on
set copyindent      " copy the previous indentation on autoindenting
set number          " show line numbers
set ruler           " show curent line and column of cursor
set shiftwidth=4    " number of spaces to use for autoindenting
set shiftround      " use multiple of shiftwidth when indenting with '<' and
                    "   '>'
set showmatch       " set show matching parenthesis
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase, case-
                    "   sensitive otherwise
set smarttab        " insert tabs on the start of a line according to the
                    "   shiftwidth, not tabstop

set hlsearch        " highlight search terms
set incsearch       " show search matches as I type

set scrolloff=5     " always show five lines below/above where the cursor is

set history=1000    " remember more commands and search history
set undolevels=1000 " use many levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class    " ignore some files for tab
                                            "   completion
set title           " change the terminal's title
set visualbell      " don't beep
set noerrorbells    " don't beep

set nobackup        " git is better
set directory=$temp " use system temporary directory for swap files

set laststatus=2    " always show the last status bar

" turn on spell checking
set spell


" tab completion for files/buffers works like bash
set wildmenu

" show a list when pressing tab and complete first full match
set wildmode=list:full


" enable mode lines (the lines that tweak vim for that file)
set modeline

" Append modeline after last line in buffer. Use substitute() instead of
" printf() to handle '%%s' modeline in LaTeX files.
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
                \ &tabstop, &shiftwidth, &textwidth)
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction

" Use <leader>ml to automatically append a modeline matching the current
" settings
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>



" gui or terminals with 256 can use the color scheme
if &t_Co >= 256 || has("gui_running")
    color wombat
endif

" gui or terminals with color can use syntax highlighing
if &t_Co > 2 || has("gui_running")
    syntax on
endif

if has("gui_running")
    set guioptions-=m " hide menu
    set guioptions-=T " hide toolbar
    set columns=120
    set lines=40
    if has("win32") || has("win64")
        set guifont=Consolas:h9
    else
        set guifont=Consolas\ 9
    endif
endif




filetype on
filetype plugin on
filetype indent on


autocmd FileType python set expandtab

" show whitespace characters in python
autocmd FileType python set list
autocmd FileType python set listchars=tab:>.,trail:.,extends:#,nbsp:.


autocmd FileType html,xml set tabstop=2 shiftwidth=2 expandtab smartindent

autocmd FileType d set expandtab


" format the current visual selection
vmap Q gq

" format the current paragraph
nmap Q gqap

" go up/down to the next visible line rather than the next logical line (when
" line wrapping is on)
nnoremap j gj
nnoremap k gk


" easier window navigation Ctrl-h rather than Ctrl-w Ctrl-h, etc.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" clear the highlighted searches easier
nmap <silent> <leader>/ : let @/=""<CR>


" NERDTree
map <F2> :NERDTreeToggle<CR>

set textwidth=78


" vim: set ts=4 sw=4 tw=78 expandtab :
