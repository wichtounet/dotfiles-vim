"""""""""""""""""""""""""""""
" Configuration for vimwiki "
"""""""""""""""""""""""""""""

" Spelling is always useul to text files
set spell

" Make sure everything is saved automatically
set autowriteall

" Better safe than sorry
au FocusLost * :wa

" Mapping
map <Leader>tt :VimwikiToggleListItem<CR>
