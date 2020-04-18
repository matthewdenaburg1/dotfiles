### Windows Subsystem for Linux

is_wsl || return 1

# allow browser links to be opened in default browser
if [[ "$(which wslview)" ]]; then
    export BROWSER="wslview"
fi

export DISPLAY=:0
