# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

# Download Vim plugins.
if [[ "$(type -P vim)" ]]; then
    curl --location --create-dirs --output $DOTFILES/link/.vim/autoload/plug.vim \
        'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    mkdir -p $DOTFILES/link/.vim/plugged

    vim +PlugInstall +qall
fi
