tbpass() {
  toolbox run pass "$@" | sed -r $'s/\x1B\\][0-9;]*[^\x07\x1B]*(\x07|\x1B\\\\)//g;s/\x1B\\[[0-9;]*[A-Za-z]//g'
}

#jira() {
#  local token
#  token="$(tbpass show work/rh/jira)"
#  if [ -t 0 ]; then
#    podman run -it --rm -v "$HOME/.config/.jira:/root/.config/.jira:Z" -e JIRA_API_TOKEN="$token" --entrypoint /bin/jira ghcr.io/ankitpokhrel/jira-cli:latest "$@"
#  else
#    bash -c 'podman run --rm -v "$HOME/.config/.jira:/root/.config/.jira:Z" -e JIRA_API_TOKEN="$1" -v /dev/null:/dev/tty --entrypoint /bin/jira ghcr.io/ankitpokhrel/jira-cli:latest "${@:2}" --plain' _ "$token" "$@"
#  fi
#}

[ -z "$PS1" ] && return # everything after this line only applies to interactive sessions

claudew() {
  local name="$1"
  shift
  local wt=".claude/worktrees/$name"
  if [ -d "$wt" ]; then
    builtin cd "$wt" && claude "$@"
  else
    claude --worktree "$name" "$@"
    if [ -d "$wt" ]; then
      builtin cd "$wt"
    fi
  fi
}

function cd {
  builtin cd "$@" && ls
}

function grep  { command grep --color=always "$@" | sed 's/:/ :/'; }
function grepi  { command grep --color=always -i "$@" | sed 's/:/ :/'; }
function grepr  { command grep --color=always -r "$@" | sed 's/:/ :/'; }
function grepri { command grep --color=always -ri "$@" | sed 's/:/ :/'; }

toolbox() {
  local _old_term
  if [[ "$TERM" == "xterm-ghostty" ]]; then
    _old_term="$TERM"
    export TERM=xterm-256color
  fi
  if [[ "$1" == "enter" ]]; then
    local _conmons_before
    _conmons_before=$(pgrep conmon 2>/dev/null || true)
    exec 3>&2 2>/dev/null
    /usr/sbin/toolbox "$@" &
    local _tbx_pid=$!
    ( sleep 1
      local _conmon_pid=""
      if [[ -n "$_conmons_before" ]]; then
        _conmon_pid=$(pgrep conmon 2>/dev/null | command grep -vxF "$_conmons_before" | head -1)
      else
        _conmon_pid=$(pgrep -n conmon 2>/dev/null)
      fi
      [[ -n "$_conmon_pid" ]] && exec pidwait-kill $_tbx_pid $_conmon_pid
    ) </dev/null >/dev/null 2>&1 &
    disown $!
    exec 2>&3 3>&-
    fg %% >/dev/null 2>&1
  else
    /usr/sbin/toolbox "$@"
  fi
  if [[ -n "$_old_term" ]]; then
    export TERM="$_old_term"
  fi
  if [[ "$1" == "enter" ]] && [ -f ~/.toolbox-last-pwd ]; then
    builtin cd "$(cat ~/.toolbox-last-pwd)"
    /usr/bin/rm -f ~/.toolbox-last-pwd
  fi
}
