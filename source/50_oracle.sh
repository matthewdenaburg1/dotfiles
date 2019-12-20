[ -x /opt/oracle/instantclient_10_2/sqlplus ] || return 1

if [[ "$(type -P rlwrap)" ]] ; then
    echo -n
else
    return 1
fi

rlwrap_opts=(
    --ansi-colour-aware
    --complete-filenames
    "--extra-char-after-completion ''"
    --pass-sigint-as-sigterm
    --multi-line
)

alias rlwrap="rlwrap ${rlwrap_opts[@]}"
alias sqlplus="rlwrap ${rlwrap_opts[@]} /opt/oracle/instantclient_10_2/sqlplus"

export RLWRAP_EDITOR="vim '+call cursor(%L,%C)'"
