### Windows Subsystem for Linux

is_ubuntu || return 1

# allow browser links to be opened in default browser
if [[ "$(which wslview)" ]]; then
	export BROWSER="wslview"
fi
