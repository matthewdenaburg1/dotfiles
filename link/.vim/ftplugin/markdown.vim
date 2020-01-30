" File: md.vim

setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=0
setlocal shiftwidth=4

setlocal foldcolumn=4
setlocal foldmethod=indent

setlocal spell
setlocal spelllang=en_us

" change the previous spelling error first suggestion
inoremap <c-l> <c-g>u<esc>[s1z=`]a<c-g>u
