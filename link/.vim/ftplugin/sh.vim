" File: sh.vim

" enable folding in bash per https://stackoverflow.com/a/38934496/664950
setlocal foldenable
setlocal foldmethod=marker
let g:sh_fold_enabled=7
let g:is_bash=1
setlocal foldmethod=syntax
