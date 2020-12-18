paths=(
    ~/.local/bin
    $DOTFILES/bin
    /usr/local/opt/coreutils/libexec/gnubin
)

export PATH
for pth in "${paths[@]}"; do
    [[ -d "$pth" ]] && PATH="$pth:$(path_remove "$pth")"
done
unset pth paths
