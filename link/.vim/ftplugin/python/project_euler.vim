


setlocal noignorecase

" make a brand new file given problem number
function! New_project_euler(filename) " {{{
    let l:number0 = substitute(a:filename, "[^0-9]*", "", "")
    let l:number = substitute(l:number0, "^0*", "", "")

    silent! 0r ~/.vim/templates/python3/project_euler_new.vim_template

    $delete

    %s/<NUMBER0>/\=l:number0/g
    %s/<NUMBER>/\=l:number/g

    echo ""

endfunction
" }}}

augroup project_euler
    autocmd!

    autocmd BufNewFile,BufEnter Problem*.py call New_project_euler(expand("%:t:r"))
augroup END

