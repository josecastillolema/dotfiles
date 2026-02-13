[ -z "$PS1" ] && return # everything after this line only applies to interactive sessions

function cd {
  builtin cd "$@" && ls
}

claude() {
  command claude "$@"
  echo -ne "\033]0;wezterm\007"
}

toolbox() {
  /usr/sbin/toolbox "$@"
  if [ -f ~/.toolbox-last-pwd ]; then
    builtin cd "$(cat ~/.toolbox-last-pwd)"
    rm -f ~/.toolbox-last-pwd
  fi
}
