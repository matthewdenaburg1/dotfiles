
set nocompatible
filetype off

" Vim plugins ("vim-plug") {{{1
call plug#begin('~/.vim/plugged/')

Plug 'tpope/vim-commentary'                   " provides comment mappings for code
Plug 'tpope/vim-surround'                     " mappings to wrap text with quotes, etc.
Plug 'tpope/vim-git'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'

Plug 'matthewdenaburg1/my-vim-snippets'

Plug 'vim-scripts/SQLComplete.vim'

Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'

Plug 'PProvost/vim-ps1', { 'for': 'ps1' }     " PowerShell plugin

Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

Plug 'vim-syntastic/syntastic'
    let g:syntastic_python_checkers = ['python3']

Plug 'jeetsukumaran/vim-indentwise'

" Builds YouCompleteMe {{{2
function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
        !python3 install.py --java-completer --clangd-completer
    endif
endfunction
" }}}2

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
    let g:ycm_filepath_completion_use_working_dir = 1
    let g:ycm_autoclose_preview_window_after_insertion  = 1

Plug 'sirver/ultisnips'
    " Ulitsnips settings - see https://stackoverflow.com/a/49193259/664950
    let g:UltiSnipsExpandTrigger = '<C-j>'
    let g:UltiSnipsJumpForwardTrigger = '<C-j>'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
    let g:UltiSnipsListSnippets = '<C-Space>'
    let g:UltiSnipsEditSplit = 'vertical'
    let g:UltiSnipsSnippetsDirectories = '$HOME/.vim/plugged/latex-snippets/UltiSnips/'

Plug 'honza/vim-snippets'

Plug 'lervag/vimtex', { 'for': 'tex' }
    " vimtex settings - see https://castel.dev/post/lecture-notes-1/
    let g:tex_flavor = 'latex'
    let g:vimtex_view_method = 'mupdf'
    let g:vimtex_quickfix_mode = 0
    let g:tex_conceal = 'abdmg'

call plug#end()
" }}}1

filetype plugin indent on
syntax enable

colorscheme slate
set background=dark

let mapleader = ","
let maplocalleader = "."


" basic settings {{{
    set number
    set relativenumber
    set numberwidth=6

    set nowrap

    set foldcolumn=4
    set foldminlines=4

    set shiftwidth=4
    set softtabstop=0
    set tabstop=4
    set expandtab

    set mouse=hn                    " Mouse in normal and help modes
    set ttymouse=xterm2             " Make the mouse work in tmux

    let &showbreak = '... '         " show '... ' on indented lines

    set belloff=all                 " turn alert bell off (src: https://stackoverflow.com/a/41524053/664950)
" }}}

" mappings {{{1
    " exit insert mode
    inoremap jk <esc>

    " Disable arrow keys in normal, visual, and insert mode
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
" }}}1

" autoresize windows on vim window size change {{{
    " :h VimResize
    " src:
    " https://www.reddit.com/r/vim/comments/fyivrb/
    if exists('$TMUX')
        autocmd VimResized * wincmd =
    endif
" }}}
