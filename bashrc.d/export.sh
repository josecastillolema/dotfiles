#export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
export EDITOR=vi
export FZF_DEFAULT_COMMAND="fd --type f"
#export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"  # does not work in toolbx
export GOROOT=$HOME/go/go-1.21.3
export GOPATH=$HOME/go
export HISTSIZE=100000                   # in memory history size
export HISTFILESIZE=100000               # on disk history size
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
#export TERMINAL=gnome-terminal
#export TERMINAL=$HOME/dev/dotfiles/wez.sh
#export VTE_VERSION=7202
