
set nocompatible
filetype off

" Vim plugins ("vim-plug") {{{1
call plug#begin('~/.vim/plugged/')
Plug 'tpope/vim-commentary'   " provides comment mappings for code
Plug 'tpope/vim-surround'     " mappings to wrap text with quotes, etc.
Plug 'tpope/vim-git'
Plug 'tpope/vim-sensible'

Plug 'tmux-plugins/vim-tmux'

Plug 'PProvost/vim-ps1'       " PowerShell plugin

Plug 'nathanaelkane/vim-indent-guides'

Plug 'vim-syntastic/syntastic'

function! BuildYCM(info)
	" info is a dictionary with 3 fields
	" - name:   name of the plugin
	" - status: 'installed', 'updated', or 'unchanged'
	" - force:  set on PlugInstall! or PlugUpdate!
	if a:info.status == 'installed' || a:info.force
		!python3 install.py --java-completer --clangd-completer
	endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }


call plug#end()

" plugin settings {{{2

" vim-syntastic/syntastic: use python3 for syntax checking
let g:syntastic_python_checkers = ['python3']

" Valloric/YouCompleteMe
let g:ycm_filepath_completion_use_working_dir = 1

" nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" }}}2
" }}}1

filetype plugin indent on
syntax enable

colorscheme slate
set background=dark

let mapleader = ","
let maplocalleader = "."


" basic settings {{{
set number relativenumber
set numberwidth=6
set mouse=hn                    " Mouse in normal and help modes
let &showbreak = '... '         " show '... ' on indented lines
set belloff=all                 " turn alert bell off (src: https://stackoverflow.com/a/41524053/664950)
" }}}

" Basic mappings {{{
" open $MYVIMRC in a vertically split window
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source $MYVIMRC
nnoremap <leader>sv :source $MYVIMRC<cr>
" exit insert mode
inoremap jk <esc>
" }}}

" Disable arrow keys in normal, visual, and insert mode {{{
inoremap <up>    <nop>
nnoremap <up>    <nop>
vnoremap <up>    <nop>
inoremap <right> <nop>
nnoremap <right> <nop>
vnoremap <right> <nop>
inoremap <down>  <nop>
nnoremap <down>  <nop>
vnoremap <down>  <nop>
inoremap <left>  <nop>
nnoremap <left>  <nop>
vnoremap <left>  <nop>
" }}}

" split right to terminal {{{
augroup split_right_to_term
	autocmd!
	autocmd FileType * command! Term :vertical rightbelow terminal
augroup END
" }}}

" vim:set filetype=vim:
