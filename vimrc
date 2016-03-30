" No vi compatibility. This must be first, because it changes other options as
" side effect
set nocompatible

call plug#begin('~/vimfiles/plugged')

" Plugins
Plug 'Wombat'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
"Plug 'python.vim'
Plug 'JesseKPhillips/d.vim'
Plug 'chrisbra/csv.vim'
"Plug 'RelOps'

" F3
Plug 'scrooloose/nerdtree'

" F2 or Ctrl-P
Plug 'kien/ctrlp.vim'

" Change surrounding character (e.g., cs([ )
Plug 'tpope/vim-surround'

" . repeat support for tpope plugins
Plug 'tpope/vim-repeat'

" git in vim
Plug 'tpope/vim-fugitive'

" Easily comment, uncommment (e.g., gcc)
Plug 'tomtom/tcomment_vim'

" Get around quickly, <leader><leader>{f,w,etc.}
Plug 'Lokaltog/vim-easymotion'

" Snippets (e.g., for<tab>)
Plug 'msanders/snipmate.vim'

Plug 'Bling/vim-airline'
Plug 'idanarye/vim-dutyl'
" Plug 'editorconfig/editorconfig-vim'
Plug 'Shougo/vimproc.vim'

call plug#end()


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 0 " Errors when vim runs under git bash on Windows
if has("gui_running")
    let g:airline_powerline_fonts = 1
endif

if has("win32") || has("win64")
    let g:dutyl_stdImportPaths=['C:\D\dmd2\src\phobos', 'C:\D\dmd2\src\druntime\import']
    call dutyl#register#tool('dcd-client', expand('$APPDATA') . '\dub\packages\dcd-0.8.0\dcd-client.exe')
    call dutyl#register#tool('dcd-server', expand('$APPDATA') . '\dub\packages\dcd-0.8.0\dcd-server.exe')
    call dutyl#register#tool('dfmt', expand('$APPDATA') . '\dub\packages\dfmt-0.4.5\dfmt.exe')
endif

filetype plugin indent on


" Better leader
let mapleader=","
nnoremap ; :


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
set t_vb=           " don't flash

set nobackup        " git is better
set noswapfile      " risky business
"set directory=$temp " use system temporary directory for swap files (never
                     " worked well for me

set laststatus=2    " always show the last status bar

" turn on spell checking
set spell


" tab completion for files/buffers works like bash
set wildmenu

" show a list when pressing tab and complete first full match
set wildmode=list:full


" Open help in a new tab rather than a small split
augroup HelpInTabs
    autocmd!
    autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END

function! HelpInNewTab ()
    if &buftype == 'help'
        "Convert the help window to a tab...
        execute "normal \<C-W>T"
    endif
endfunction


" Use Ctrl-Space for omnicompletion
imap <c-space> <c-x><c-o>


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
    set background=dark
    color Wombat
    "colorscheme solarized
    "colorscheme base16-default
endif

" gui or terminals with color can use syntax highlighing
if &t_Co > 2 || has("gui_running")
    syntax on
endif

set encoding=utf-8
if has("gui_running")
    set guioptions-=m " hide menu
    set guioptions-=T " hide toolbar
    set columns=120
    set lines=40
    if has("win32") || has("win64")
        set guifont=Sauce\ Code\ Powerline:h9
    elseif has("mac")
        set guifont=Sauce\ Code\ Powerline:h11
    else
        set guifont=Consolas\ 9
    endif
endif




autocmd FileType python set expandtab

" show whitespace characters by default everywhere
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.


autocmd FileType html,xml set tabstop=2 shiftwidth=2 expandtab smartindent

autocmd FileType ruby set tabstop=2 shiftwidth=2 expandtab smartindent

autocmd FileType d set expandtab

autocmd FileType cmake set tabstop=2 shiftwidth=2 expandtab smartindent

augroup filetype
    au! BufRead,BufNewFile *.proto setfiletype proto
augroup end


" format the current visual selection
vmap Q gq

" format the current paragraph
nmap Q gqap

nmap <A-space> ==

" go up/down to the next visible line rather than the next logical line (when
" line wrapping is on)
nnoremap j gj
nnoremap k gk

set virtualedit=block


" easier window navigation Ctrl-h rather than Ctrl-w Ctrl-h, etc.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" clear the highlighted searches easier
nmap <silent> <leader>/ : let @/=""<CR>

" Map spacebar to write the buffer to disk
nnoremap <Space> :w<CR>

" CtrlP
map <F2> :CtrlP<CR>

" NERDTree
map <F3> :NERDTreeToggle<CR>

" Ident=Guides
map <F4> <leader>ig

" prevent pasting over from filling register
" I haven't found how to hide this function (yet)
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()


set textwidth=0


" vim: set ts=4 sw=4 tw=78 expandtab :
