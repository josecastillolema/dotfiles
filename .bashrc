# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# User specific environment and startup programs
#if ! [ -f /run/.toolboxenv ]; then
#    [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
#fi

export EDITOR=vim
#export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
source <(kubectl completion bash)
alias k=kubectl
alias d=docker
alias watch="watch "
alias ls="ls --color -B"
alias grep="grep --color"
alias grepi="grep --color -i"
alias grepri="grep --color -ri"
alias g=grep
alias gi=grepi
alias gri=grepri
alias c=cat
alias ll='ls -lFh'
alias la='ls -A'
alias l='ls'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../..'
alias cd-='cd -'
alias cd--='cd --'
alias code='flatpak run com.visualstudio.code'
alias v=vim
alias open=xdg-open
alias o=xdg-open

# TODO: time of previous command

RED="31"
GREEN="\e[32m"
BLUE="\e[34m"
CYAN="\e[36m"
BROWN="\e[33m"
BOLDGREEN="\e[1;${GREEN}m"
ITALICRED="\e[3;${RED}m"
ENDCOLOR="\e[0m"

parse_git_branch() {
    echo -e "$BROWN$(parse_git_branch2)$ENDCOLOR"
}

parse_git_branch2() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

function is_toolbox() {
    if [ -f "/run/.toolboxenv" ]
    then
        if [[ $name = "fedora-toolbox-38" ]]; then
           echo -e "$BLUE⬢ $ENDCOLOR"
        else
           echo -e "$CYAN⬢ $ENDCOLOR"
        fi
    fi
}

PS1='\n\e[34m\]\w \[\e[0;$(($?==0?0:91))m\]❯ \[\e[0m\]$(is_toolbox)$(parse_git_branch)'

# toolbox
if [ -f /run/.toolboxenv ]; then
    source /run/.containerenv
    printf "\033]777;container;pop;;\033\\"
    export PATH="$PATH:~/.local/bin/toolbox"
    alias podman='flatpak-spawn --host podman'
    alias open='flatpak-spawn --host xdg-open'
    alias code='flatpak-spawn --host flatpak run com.visualstudio.code'
    if [[ $name = "ocaml" ]]; then
        test -r /var/home/jose/.opam/opam-init/init.sh && . /var/home/jose/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
    fi
fi
