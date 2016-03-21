" vimrc
" Author: Baptiste Wicht

" Be vim (no vi)
if !has('nvim')
    set nocompatible
endif

filetype on
filetype off

" Configure encoding
set encoding=utf-8
set termencoding=utf-8

" Set color mode (if not neovim)
if !has('nvim')
    set term=xterm-256color
endif

" Good compatibility with zsh
if executable('zsh')
  set shell=zsh\ -l
endif

" Improve redrawing smoothness by assuming that my terminal is reasonably fast
if !has('nvim')
    set ttyfast
endif

" Don't bother drawing the screen while executing macros or other automated or
" scripted processes, just draw the screen as it is when the operation
" completes
set lazyredraw

" Don't bother about checking whether Escape is being used as a means to enter
" a Meta-key combination, just register Escape immediately
set noesckeys

" Auto write
set autowrite

" Reload files if changed from shell command
set autoread

" Beeps are outdated...
set visualbell

" Activate mode lines
filetype plugin on
set modeline
set modelines=5

" Display relative number
if exists('+relativenumber')
  set relativenumber
endif

" Enable persistent undo
if has('persistent_undo')
    set undolevels=5000
    set undoreload=10000
    set undofile
    set undodir=$HOME/.vim/tmp/undo
endif

" More memory for commands
set history=1000

" Disable reading of .vimrc in current directory
set noexrc
set secure

" Rotate swap files more often
set updatecount=100

" Practical settings
set nobinary
set eol

" Set a timeout for keybindings
set timeout
set timeoutlen=750

" Use space as mapleader
let mapleader = "\<Space>"

" BEGIN Plugins

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"""" The NERD tree

Bundle 'scrooloose/nerdtree'

" Keep the window fixed between multiple toggles
set winfixwidth

nmap <TAB> :NERDTreeToggle<CR>

"""" The NERD Commented

Bundle 'scrooloose/nerdcommenter'

"""" yank-stack

Bundle 'maxbrunsfeld/vim-yankstack'

nmap <Leader>p <Plug>yankstack_substitute_older_paste
nmap <Leader>P <Plug>yankstack_substitute_newer_paste

"""" Molokai Color Scheme

Bundle 'tomasr/molokai'

"""" CtrlP

Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = ''

"""" vim-eunuch (file manipulation from vim)

Bundle 'tpope/vim-eunuch'

"""" vim-markdown

Bundle 'tpope/vim-markdown'

au BufNewFile,BufReadPost *.md set filetype=markdown

let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

"""" vim-fugitive (git)

Bundle 'tpope/vim-fugitive'

nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit -v<CR>
nmap <leader>gac :Gcommit --amend -v<CR>
nmap <leader>g :Ggrep
" ,f for global git search for word under the cursor (with highlight)
nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
" same in visual mode
vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

"""" gitv (git)

Bundle 'gregsexton/gitv'

nmap <leader>gv :Gitv<CR>

"""" vim-airline (fancy)

Bundle 'bling/vim-airline'

"""" riv.vim (RestructuredText)

Bundle 'Rykka/riv.vim'

"""" InstantRst (RestructuredText)

Bundle 'Rykka/InstantRst'

"""" vimwiki

Bundle 'vimwiki/vimwiki'

"""" vim-dispatch (async make)

Bundle 'tpope/vim-dispatch'

"""" vim-surround (advanced surround support)

Bundle 'tpope/vim-surround'

"""" vim-repeat (repeat support for vim-surround)

Bundle 'tpope/vim-repeat'

""""" Reindent

Bundle 'vim-scripts/Reindent'

""""" vim-endwise (automatically end preprocessor macros)

Bundle 'tpope/vim-endwise'

""""" ag (search on steroids)

Bundle 'rking/ag.vim'

""""" color_coded (better c++ highlighting)

if !has('nvim')
    Bundle 'jeaye/color_coded'

    let g:color_coded_filetypes = ['c', 'cpp']
    nmap <Leader>c :CCtoggle<CR>
endif

" END Plugins

call vundle#end()
filetype plugin on
filetype plugin indent on

" Plugins initializations

call yankstack#setup()

" ctrlp and the silver searcher

if executable('ag')
    " Prefer ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " use ag in CtrlP for listing files (fast and respects .gitignore)
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP does not need a cache
    let g:ctrlp_use_caching = 0
else
    " Respect .gitignore with git ls-files and find
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
                \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
                \ }
endif

" Configure backups
set backupdir=$HOME/.vim/tmp/backup

" Configure swap
set directory=$HOME/.vim/tmp/swap
set backup
set noswapfile

" Configure the dictionary
set dictionary=/usr/share/dict/words

" Enable spelling on text files
au BufEnter *.tex set spell
au BufEnter *.rst set spell
au BufEnter *.md set spell
au BufEnter *.txt set spell

" Display {{{

syntax on

if filereadable(globpath(&rtp, 'colors/molokai.vim'))
   colorscheme molokai
endif

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Display the current command in the bottom line
set showcmd

" Always display the ruler
set ruler

" Enable the wild menu for better command completion
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc
set wildmenu

" Show parenths matchings
set showmatch
set matchtime=2

" Minimal number of columns for the line number
set numberwidth=3

" Minimal width of a window in case of several windows
set winwidth=83

" Option for completion
set completeopt=longest,menuone,preview

" Disable folding in riv.vim
set nofoldenable
let g:riv_disable_folding = 1
let g:riv_fold_auto_update = 0

" Disable code indicator for riv.vim
let g:riv_code_indicator = 0

" Add support for airline
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols_branch = '⭠'
let g:airline_symbols_readonly = '⭤'
let g:airline_symbols_linenr = '⭡'

let g:indentLine_char = '│'

" Open and close quick fix window automatically
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Make sure to close the completion window
autocmd CompleteDone * pclose

" }}}

" Triggers {{{

" Save when losing focus
au FocusLost    * :silent! wall

" }}}

" White characters {{{

set autoindent
set tabstop=4
set softtabstop=4
set textwidth=80
set shiftwidth=4
set expandtab
set wrap
set formatoptions=qrn1
if exists('+colorcolumn')
  set colorcolumn=+1
endif
set cpo+=J

set backspace=indent,eol,start
set cinoptions=:0,(s,u0,U1,g0,t0
set completeopt=menuone,preview
set encoding=utf-8
set hidden
set laststatus=2
set list

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
set showbreak=↪

" Only shown when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:␣
    au InsertLeave * :set listchars+=trail:␣
augroup END

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Remove trailing whitespaces when saving
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" }}}

" Search {{{

" Incremental search
set incsearch

" Search for selection
vnoremap // y/<C-R>"<CR>

" sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set showmatch
set gdefault
set hlsearch

" Don't jump when using * for search
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Fast map for Ag
nnoremap <leader>a :Ag -i<space>

" clear highlight after search
noremap <silent><Leader>/ :nohls<CR>

" Set 5 lines to the cursor - when moving vertically
set scrolloff=0

" }}}

" Navigation {{{

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Improve navigation between windows
noremap rj <C-w>j
noremap rk <C-w>k
noremap rh <C-w>h
noremap rl <C-w>l
noremap rc <C-w>c
noremap rs <C-w>s
noremap ro <C-w>o
noremap r<SPACE> :split<CR>
noremap r<CR> :vsplit<CR>
noremap r <C-w>

" Improve navigation in quick fix window
nnoremap cn :cnext<CR>
nnoremap cp :cprevious<CR>
nnoremap cc :cclose<CR>

nnoremap M :next<CR>
nnoremap P :previous<CR>

" Map easily tab change
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>

" Arrow keys are evil :)
nnoremap <Left> :echoe "Use h, you moron..."<CR>
nnoremap <Right> :echoe "Use l, you moron..."<CR>
nnoremap <Up> :echoe "Use k, you moron..."<CR>
nnoremap <Down> :echoe "Use j, you moron..."<CR>

" Easy buffer navigation
noremap <leader>bp :bprevious<cr>
noremap <leader>bn :bnext<cr>

" Easy splitted window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Hightlight the current line
set cursorline

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END

" Should improve quickfix, but does not seems to work as expected
set switchbuf=useopen
nnoremap mc :cclose<CR>:q<CR>

" }}}

" Mappings {{{

" ESC insert mode with jj
inoremap jj <ESC>

" ESC visual mode with J
vnoremap J <ESC>

" Better user of Leader
nnoremap <Leader>w :w <CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>j :set nofoldenable<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader><Space> :

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <Leader>v <C-w>v<C-w>l
nnoremap <Leader>h <C-w>s<C-w>j

" Yank from current cursor position to end of line
map Y y$

"  Use clang-format to format the file or the selection
nnoremap <Leader>r :pyf /usr/lib/clang-format.py<CR>
vnoremap <Leader>r :pyf /usr/lib/clang-format.py<CR>

" Ease the use fugitive
nnoremap ss :Gstatus<CR>

" Make fast
nnoremap mm :wa<bar>Make<CR>
nnoremap mf :wa<bar>Make -j7<CR>
nnoremap mc :wa<bar>Make clean<CR>

" }}}

" Miscelleanous {{{

" Better file printing
let &printexpr="(v:cmdarg=='' ? ".
    \"system('lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice)".
    \". ' ' . v:fname_in) . delete(v:fname_in) + v:shell_error".
    \" : system('mv '.v:fname_in.' '.v:cmdarg) + v:shell_error)"

" File management with git
au! BufRead /home/wichtounet/vimwiki/index.wiki execute ':silent ! git -C /home/wichtounet/vimwiki/ pull > /dev/null 2>&1 ;'

" Good indentations of git commits

autocmd FileType gitcommit set tw=68 spell
autocmd FileType gitcommit setlocal foldmethod=manual

" Surrounding

fun! Surround(s1, s2) range
  exe "normal vgvmboma\<Esc>"
  normal `a
  let lineA = line(".")
  let columnA = col(".")
  normal `b
  let lineB = line(".")
  let columnB = col(".")
  " exchange marks
  if lineA > lineB || lineA <= lineB && columnA > columnB
    " save b in c
    normal mc
    " store a in b
    normal `amb
    " set a to old b
    normal `cma
  endif
  exe "normal `ba" . a:s2 . "\<Esc>`ai" . a:s1 . "\<Esc>"
endfun

"  Surround code
vnoremap <Leader>f :call Surround(':code:`', '`')<CR>

augroup ft_vim
    au!
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}
