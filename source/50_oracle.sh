[[ -x "${ORACLE_HOME}/bin/sqlplus" ]] || return 1

if [[ "$(type -P rlwrap)" ]] ; then
    echo -n
else
    return 1
fi

rlwrap_opts=(
    -A      # --ansi-colour-aware
    -c      # --complete-filenames
    "-e ''" # "--extra-char-after-completion ''"
    -I      # --pass-sigint-as-sigterm
    -m      # --multi-line
)

alias rlwrap="rlwrap ${rlwrap_opts[@]}"
alias sqlplus="rlwrap ${rlwrap_opts[@]} sqlplus"

export RLWRAP_EDITOR="vim '+call cursor(%L,%C)'"
