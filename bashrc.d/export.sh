#export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
export CONTAINER_ENGINE=podman-remote # for openshift/release
export DOCKER_HOST=unix:///run/user/1000/docker.sock
export EDITOR=vi
export FZF_DEFAULT_COMMAND="fd --type f"
#export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"  # does not work in toolbx
export GOROOT=$HOME/go/go-1.21.3
export GOPATH=$HOME/go
export HISTSIZE=100000                   # in memory history size
export HISTFILESIZE=100000               # on disk history size
export PATH=$PATH:/var/lib/flatpak/exports/bin:~/.local/share/flatpak/exports/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
#export TERMINAL=gnome-terminal
#export TERMINAL=$HOME/dev/dotfiles/wrappers/wez.sh
#export VTE_VERSION=7202
export WHAT=openshift-qe/ocp-qe-perfscale-ci # for openshift/release
