[ -z "$PS1" ] && return # everything after this line only applies to interactive sessions

function cd {
  builtin cd "$@" && ls
}

toolbox() {
  /usr/sbin/toolbox "$@"
  if [[ "$1" == "enter" ]] && [ -f ~/.toolbox-last-pwd ]; then
    builtin cd "$(cat ~/.toolbox-last-pwd)"
    /usr/bin/rm -f ~/.toolbox-last-pwd
  fi
}
