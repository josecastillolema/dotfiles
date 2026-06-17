tbpass() {
  toolbox run pass "$@" | sed -r $'s/\x1B\\][0-9;]*[^\x07\x1B]*(\x07|\x1B\\\\)//g;s/\x1B\\[[0-9;]*[A-Za-z]//g'
}

jira() {
  local token
  token="$(tbpass show work/rh/jira)"
  if [ -t 0 ]; then
    podman run -it --rm -v "$HOME/.config/.jira:/root/.config/.jira:Z" -e JIRA_API_TOKEN="$token" --entrypoint /bin/jira ghcr.io/ankitpokhrel/jira-cli:latest "$@"
  else
    bash -c 'podman run --rm -v "$HOME/.config/.jira:/root/.config/.jira:Z" -e JIRA_API_TOKEN="$1" -v /dev/null:/dev/tty --entrypoint /bin/jira ghcr.io/ankitpokhrel/jira-cli:latest "${@:2}" --plain' _ "$token" "$@"
  fi
}

[ -z "$PS1" ] && return # everything after this line only applies to interactive sessions

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
  /usr/sbin/toolbox "$@"
  if [[ -n "$_old_term" ]]; then
    export TERM="$_old_term"
  fi
  if [[ "$1" == "enter" ]] && [ -f ~/.toolbox-last-pwd ]; then
    builtin cd "$(cat ~/.toolbox-last-pwd)"
    /usr/bin/rm -f ~/.toolbox-last-pwd
  fi
}
