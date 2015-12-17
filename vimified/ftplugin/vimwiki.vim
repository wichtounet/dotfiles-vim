"""""""""""""""""""""""""""""
" Configuration for vimwiki "
"""""""""""""""""""""""""""""

" Spelling is always useul to text files
set spell

" Make sure everything is saved automatically
set autowriteall

" Mapping
map <Leader>tt :VimwikiToggleListItem<CR>

" File management with git
augroup vimwiki
    au!
    au! FocusLost * :wa
    au! BufRead /home/wichtounet/vimwiki/index.wiki execute ':silent ! git -C /home/wichtounet/vimwiki/ pull > /dev/null 2>&1 ;'
    au! BufWritePost /home/wichtounet/vimwiki/* execute ':silent !
        \ git -C /home/wichtounet/vimwiki/ add /home/wichtounet/vimwiki/* > /dev/null 2>&1 ;
        \ git -C /home/wichtounet/vimwiki/ commit -a -m "wichtounet auto commit"> /dev/null 2>&1 ;
        \ git -C /home/wichtounet/vimwiki/ push > /dev/null 2>&1 ;'
augroup END
