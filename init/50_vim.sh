# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim/{swap,undo,backup}

# Download Vim plugins.
if [[ "$(type -P vim)" ]]; then
    mkdir -p $DOTFILES/link/.vim/autoload/

    ln -s -f $DOTFILES/vendor/vim-plug/plug.vim $DOTFILES/link/.vim/autoload/plug.vim

    vim +PlugInstall +qall
fi
