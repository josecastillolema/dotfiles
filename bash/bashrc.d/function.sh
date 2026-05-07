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
