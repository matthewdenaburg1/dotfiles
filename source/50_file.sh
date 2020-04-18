# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs  755 drwxr-xr-x (777 minus 022)
umask 022

# Always use color output for `ls`
if is_osx; then
    if [[ "$(type -P gls)" ]]; then
        # if we have gnu's coreutil
        alias ls="command gls --color"
        alias la="command gls --color -A"
    else
        alias ls="command ls -G -A"
    fi
else
    alias ls="command ls --color"
    alias la="command ls --color -A"
fi
if [[ "$(type -P gdircolors)" ]]; then
    eval "$(gdircolors -b ~/.dircolors)"
else
    export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# Directory listing
if [[ "$(type -P tree)" ]]; then
    alias ll='tree --dirsfirst -apughDFiC -L 1'
    alias lsd='ll -d'
    alias mytree='tree -C -a -I ".cache|.git*" -L 10 --filelimit 30'
else
    alias la='ls -A'
    alias ll='ls -Ahl'
    alias lsd='CLICOLOR_FORCE=1 ll | grep --color=never "^d"'
fi

# Easier navigation: .., ..., -
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'

# File size
alias fs="stat -f '%z bytes'"
alias df="df -h"

# Recursively delete `.DS_Store` files
alias dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Aliasing eachdir like this allows you to use aliases/functions as commands.
alias eachdir=". eachdir"

# Create a new directory and enter it
function md() {
    mkdir -p "$@" && cd "$@"
}

# # Fast directory switching
# mkdir -p $DOTFILES/caches/z
# _Z_NO_PROMPT_COMMAND=1
# _Z_DATA=$DOTFILES/caches/z/z
# . $DOTFILES/vendor/z/z.sh
