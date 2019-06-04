# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

# Download Vim plugins.
if [[ "$(type -P vim)" ]]; then
    bundle="$DOTFILES/link/.vim/bundle/"
    mkdir -p "$bundle"
    [[ -d "$bundle/Vundle.vim/" ]] || git clone 'https://github.com/VundleVim/Vundle.vim/' "$bundle/Vundle.vim"
    vim +PluginInstall +qall
fi
