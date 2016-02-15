" Enable spelling on text files
au BufEnter *.tex set spell
au BufEnter *.rst set spell

" Improve redrawing smoothness by assuming that my terminal is reasonably fast
set ttyfast

" Don't bother drawing the screen while executing macros or other automated or
" scripted processes, just draw the screen as it is when the operation
" completes
set lazyredraw

" Don't bother about checking whether Escape is being used as a means to enter
" a Meta-key combination, just register Escape immediately
set noesckeys

" Use space as mapleader
let mapleader = "\<Space>"

" Put all backup files at the same place
set backupdir=~/vimified/tmp/backup/

" Configure syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++1y -stdlib=libc++'
let g:syntastic_use_quickfix_lists = 1

" Search for selection
vnoremap // y/<C-R>"<CR>

" ESC insert mode with jj
inoremap jj <ESC>

" ESC visual mode with J
vnoremap J <ESC>

" Activate breakindent
" TODO Find a way to reactivate this
" set breakindent

" Activate mode lines
set nocompatible
filetype plugin on
set modeline
set modelines=5

" Disable folding
set nofoldenable
let g:riv_disable_folding = 1
let g:riv_fold_auto_update = 0

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

" Better user of Leader
nnoremap <Leader>w :w <CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>j :set nofoldenable<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader><Space> :

" Map easily tab change
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>

" Should improve quickfix, but does not seems to work as expected
set switchbuf=
nnoremap mc :cclose<CR>:q<CR>

" Ease the use fugitive
nnoremap ss :Gstatus<CR>

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

" Make fast
nnoremap mm :wa<bar>Make<CR>
nnoremap mf :wa<bar>Make -j7<CR>
nnoremap mc :wa<bar>Make clean<CR>

" Improve navigation in quick fix window
nnoremap cn :cnext<CR>
nnoremap cp :cprevious<CR>
nnoremap cc :cclose<CR>

nnoremap M :next<CR>
nnoremap P :previous<CR>

" Open and close quick fix window automatically
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Disable reading of .vimrc in current directory
set noexrc

" Set a timeout for keybindings
set timeout
set timeoutlen=750

" Arrow keys are evil :)
nnoremap <Left> :echoe "Use h, you moron..."<CR>
nnoremap <Right> :echoe "Use l, you moron..."<CR>
nnoremap <Up> :echoe "Use k, you moron..."<CR>
nnoremap <Down> :echoe "Use j, you moron..."<CR>


" Make sure to close the completion window
autocmd CompleteDone * pclose

" Tabs
set expandtab

" Auto write
set autowrite

" Put all undo files at the same place
if has('persistent_undo')
    set undolevels=5000
    set undodir=$HOME/.vim_undo
    set undofile
endif

" Rotate swap files more often
set updatecount=100

" Practical settings
set nobinary
set eol

" ctrlp

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

"  Use clang-format to format the file or the selection
nnoremap <Leader>r :pyf /usr/lib/clang-format.py<CR>
vnoremap <Leader>r :pyf /usr/lib/clang-format.py<CR>

" File management with git
au! BufRead /home/wichtounet/vimwiki/index.wiki execute ':silent ! git -C /home/wichtounet/vimwiki/ pull > /dev/null 2>&1 ;'
