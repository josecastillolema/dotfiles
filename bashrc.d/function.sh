[ -z "$PS1" ] && return # everything after this line only applies to interactive sessions

function cd {
    builtin cd "$@" && ls
}
