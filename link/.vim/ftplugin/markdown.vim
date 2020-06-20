" File: md.vim

setlocal spell
setlocal spelllang=en_us

" change the previous spelling error first suggestion
inoremap <c-l> <c-g>u<esc>[s1z=`]a<c-g>u
