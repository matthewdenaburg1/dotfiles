#!/usr/local/bin/env bash

# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH="/usr/local/bin:$(path_remove /usr/local/bin)"
export PATH

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Make 'less' more.
[[ "$(type -P lesspipe.sh)" ]] && eval "$(lesspipe.sh)"

# Start ScreenSaver. This will lock the screen if locking is enabled.
alias ss="open -a ScreenSaverEngine.app"

function __hidden_files_help() {
    cat <<EOF
Usage:
    hidden_files [-h] [STATUS]

Description:
    Enables or disables hidden files in the Apple file system.

    The STATUS is one of:
    on  | 1		Enable display of hidden files
    off | 1		Disable display of hidden files

    If absent, toggle the setting.

    -h          Print this help message
EOF
}

function hidden_files() {
    # check if we need help
    while getopts "h" opt; do
        case $opt in
            h|\?)
                __hidden_files_help
                return 0
                ;;
        esac
    done
    shift $((OPTIND-1))

    # if no argument was provided, we are toggling
    if [[ $# -eq 0 ]]; then
        # get the current value
        curr_val=$(defaults read com.apple.finder AppleShowAllFiles)
        case $curr_val in
            0)  action=1;;
            1)  action=0;;
            *)  action=0;;
        esac
    else
        action=$1
    fi

    # determine what what we want to do
    case $action in
        on|1)
            value=1
            print_val=on
            ;;
        off|0)
            value=0
            print_val=off
            ;;
        *)
            __hidden_files_help
            return 1
            ;;
    esac

    # do it and save the exit code
    defaults write com.apple.finder AppleShowAllFiles $value
    result=$?
    # restart Finder if we successfully updated, and inform the user
    [[ $result ]] && killall Finder && echo -e "Hidden files are: $print_val"
    # return
    return $result
}
