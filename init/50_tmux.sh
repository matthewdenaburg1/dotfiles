#### install tmux plugins

# only run if ubuntu or osx
(is_ubuntu || is_osx) || exit 1

# if tmux is not installed, exit.
command -v tmux &> /dev/null || exit 1


## the following from: https://github.com/tmux-plugins/tpm/issues/6

# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required, I guess
tmux kill-server
