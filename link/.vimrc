
set nocompatible
filetype off

" Vim plugins ("Vundle") {{{
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'   " Vim Package Manager

Plugin 'PProvost/vim-ps1'       " PowerShell plugin

Plugin 'tpope/vim-commentary'   " provides comment mappings for code
Plugin 'tpope/vim-liquid'       " liquid syntax highlighting
Plugin 'tpope/vim-surround'     " mappings to wrap text with quotes, etc.
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-sensible'

Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'vim-syntastic/syntastic'

Plugin 'Valloric/YouCompleteMe' " code completion
" Plugin 'davidhalter/jedi-vim'   " python 3 code completion

call vundle#end()
" }}}

filetype plugin indent on
syntax enable

let mapleader = ","
let maplocalleader = "."

" autocompletion {{{
" YouCompleteMe
let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_filepath_completion_use_working_dir = 1
let g:indent_guides_enable_on_vim_startup = 1


" jedi
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#completions_command = '<C-N>'
" }}}

" basic settings {{{
set number relativenumber
set numberwidth=6
set mouse=hn                    " Mouse in normal and help modes
let &showbreak = '... '         " show '... ' on indented lines
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
