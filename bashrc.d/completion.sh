source <(docker completion bash)
complete -o default -F __start_docker d

source <(kubectl completion bash)
complete -o default -F __start_kubectl k

. /usr/share/bash-completion/completions/podman
complete -o default -F __start_podman p
