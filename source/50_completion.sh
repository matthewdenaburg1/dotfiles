#!/usr/local/bin/env bash

completions=()

if is_osx; then
    # brew puts some bash completion stuff in /usr/local/etc/bash_completion.d
    COMPLETION_LOC='/usr/local/etc/bash_completion.d'

    completions+=(
        $COMPLETION_LOC/git-completion.bash
        $COMPLETION_LOC/brew
        $COMPLETION_LOC/tmux
    )
    # googler
    if [[ "$(type -P googler)" ]]; then
        completions+=($COMPLETION_LOC/googler-completion.bash)
    fi
    # todo.sh
    if [[ "$(type -P todo.sh)" ]]; then
        completions+=($COMPLETION_LOC/todo_completion)
    fi
    # bash completion
    if [[ -d '/usr/local/share/bash-completion/bash_completion' ]]; then
        completions+=(/usr/local/share/bash-completion/bash_completion)
    fi
    unset COMPLETION_LOC
fi
if is_ubuntu; then
    # mvn - https://github.com/juven/maven-bash-completion
    completions+=($DOTFILES/vendor/maven-bash-completion/bash_completion.bash)
    # tmux - https://github.com/imomaliev/tmux-bash-completion
    completions+=($DOTFILES/vendor/tmux-bash-completion/completions/tmux)
fi

if (( ${#completions[@]} > 0 )) ; then
    for loc in "${completions[@]}"; do
        [[ -e "$loc" ]] && source $loc
    done
    unset loc
fi
unset completions

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip3
complete -o default -F _pip_completion pip
# pip bash completion end
