# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

# Homebrew recipes
recipes=(
  align
  ant
  bash
  bash-completion@2
  bat
  catimg
  coreutils
  csv-fix
  curl
  diff-pdf
  diff-so-fancy
  findutils
  gawk
  gcal
  gcc
  gettext
  git
  git-extras
  glib
  gnu-sed
  gnu-time
  go
  googler
  grep
  highlight
  htop-osx
  hr
  jq
  less
  lesspipe
  mysql
  newsboat
  p7zip
  pdfgrep
  perl
  pinentry
  python
  readline
  reattach-to-user-namespace
  remind
  rename
  rmlint
  sqlite
  thefuck
  tmux
  todo-txt
  trash
  tree
  vim
  wget
  whois
  wtf
)

brew_install_recipes

# Misc cleanup!

# This is where brew stores its binary symlinks
local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# htop
if [[ "$(type -P $binroot/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$binroot/htop")" != "root:wheel" ]]; then
  e_header "Updating htop permissions"
  sudo chown root:wheel "$binroot/htop"
  sudo chmod u+s "$binroot/htop"
fi

# bash
if [[ "$(type -P $binroot/bash)" && "$(cat /etc/shells | grep -q "$binroot/bash")" ]]; then
  e_header "Adding $binroot/bash to the list of acceptable shells"
  echo "$binroot/bash" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/bash" ]]; then
  e_header "Making $binroot/bash your default shell"
  sudo chsh -s "$binroot/bash" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
