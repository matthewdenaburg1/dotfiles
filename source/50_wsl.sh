### Windows Subsystem for Linux

is_wsl || return 1

# allow browser links to be opened in default browser
if command -v wslview >/dev/null 2>&1; then
    export BROWSER="wslview"
    export DISPLAY=:0
fi
