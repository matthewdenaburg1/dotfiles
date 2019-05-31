# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

# Download Vim plugins.
if [[ "$(type -P vim)" ]]; then
  mkdir -p "$DOTFILES/link/.vim/bundle/"
  git clone 'https://github.com/VundleVim/Vundle.vim/' "$DOTFILES/link/.vim/bundle/Vundle.vim"
  vim +PluginInstall +qall
fi
