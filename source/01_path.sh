ORACLE_HOME=/opt/oracle/instantclient_10_2
[[ -d $ORACLE_HOME ]] && export ORACLE_HOME

paths=(
    ~/.local/bin
    $DOTFILES/bin
    /usr/local/opt/coreutils/libexec/gnubin
    $ORACLE_HOME/bin
)

libs=(
    $ORACLE_HOME/lib
)

export LD_LIBRARY_PATH
for lib in "${libs[@]}"; do
    [[ -d "$lib" ]] && LD_LIBRARY_PATH="$lib:$(lib_path_remove "$lib")"
done

export PATH
for pth in "${paths[@]}"; do
    [[ -d "$pth" ]] && PATH="$pth:$(path_remove "$pth")"
done
unset lib libs pth paths
