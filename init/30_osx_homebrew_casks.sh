# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask kegs are installed.
kegs=(
    caskroom/cask
    caskroom/drivers
    caskroom/fonts
)
brew_tap_kegs

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Homebrew casks
casks=(
    # Applications
    alfred
    db-browser-for-sqlite
    discord
    dropbox
    eclipse-ide
    firefox
    flip4mac
    geektool
    github
    google-backup-and-sync
    google-chrome
    gyazo
    istat-menus
    iterm2
    jing
    joinme
    kindle
    microsoft-office
    minecraft
    music-manager
    onedrive
    puush
    puzzles
    runescape
    skype
    steam
    teamviewer
    virtualbox
    vlc
    xquartz
    xscreensaver
    zoom
    # Quick Look plugins
    qlcolorcode
    qlmarkdown
    qlprettypatch
    qlstephen
    quicklook-csv
    quicklook-json
    quicknfo
    webpquicklook
    # Color pickers
    colorpicker-developer
    colorpicker-skalacolor
)

cask_flags=(
    --no-binaries
    --appdir=/Applications
    --fontdir=~/Library/Fonts
    --servicedir=~/Library/Services
    --colorPickerdir=~/Library/ColorPickers
    --prefpanedir=~/Library/PreferencePanes
    --qlplugindir=~/Library/QuickLook
    --screen_saverdir=~/Library/Screen\ Savers
)


# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
    e_header "Installing Homebrew casks: ${casks[*]}"
    for cask in "${casks[@]}"; do
        brew cask install $cask "${cask_flags[@]}"
    done
    # brew cask cleanup
fi

# Work around colorPicker symlink issue.
# https://github.com/caskroom/homebrew-cask/issues/7004
cps=()
for f in ~/Library/ColorPickers/*.colorPicker; do
    [[ -L "$f" ]] && cps=("${cps[@]}" "$f")
done

if (( ${#cps[@]} > 0 )); then
    e_header "Fixing colorPicker symlinks"
    for f in "${cps[@]}"; do
        target="$(readlink "$f")"
        e_arrow "$(basename "$f")"
        rm "$f"
        cp -R "$target" ~/Library/ColorPickers/
    done
fi
