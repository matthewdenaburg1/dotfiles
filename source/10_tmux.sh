# Start new tmux session or reattach to an existing session, but only if not
# already inside a tmux session.

# see https://stackoverflow.com/a/55426747/664950
function tmuxstart() {
  # if the session named 'local' is attached, use a new session. don't attach a second time.
  if tmux list-sessions | grep -E 'local.*attached' >/dev/null 2>&1; then
    tmux new-session
  else  # otherwise, attach 'local'
    tmux attach-session -t local
  fi
}


# see https://unix.stackexchange.com/a/113768/391864
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  shopt -q login_shell && tmuxstart
fi

# Run an arbitrary command in the current tmux window (if only one pane)
# otherwise create a new window and run the command there.
function run_in_fresh_tmux_window() {
  local panes="$(tmux list-panes | wc -l)"
  if [[ "$panes" != 1 ]]; then
    tmux new-window "bash --rcfile <(echo '. ~/.bashrc; $*')"
  else
    "$@"
  fi
}

# Open editor and shell in new window using main-vertical layout.
# Usage: qq [num-panes] [working-directory] [...other-args]
function qq() {
  local panes=1; [[ "$1" =~ ^[0-9]+$ ]] && panes=$1 && shift
  local dir="$PWD"; [[ -d "$1" ]] && dir="$(cd "$1" && pwd)" && shift
  local win=$(tmux new-window -P -a -c "$dir" -n "$(basename "$dir")")
  n_times $panes tmux split-window -t $win -c "$dir"
  tmux select-layout -t $win main-vertical
  tmux select-pane -t $win
  tmux send-keys -t $win "$EDITOR $@" Enter
}
alias q2='qq 2'
alias q3='qq 3'
