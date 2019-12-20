ORACLE_HOME=/opt/oracle/instantclient_10_2/
export ORACLE_HOME

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
for l in "${libs[@]}"; do
	[[ -d "$l" ]] && LD_LIBRARY_PATH="$l:$(lib_path_remove "$l")"
done

export PATH
for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
done
unset l libs p paths
