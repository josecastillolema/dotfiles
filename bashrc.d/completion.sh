source <(docker completion bash)
complete -o default -F __start_docker d

source <(kubectl completion bash)
complete -o default -F __start_kubectl k

source <(oc completion bash)

if [ ! -f /run/.toolboxenv ]; then
  . /usr/share/bash-completion/completions/podman
  complete -o default -F __start_podman p
fi

#export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
#source <(carapace _carapace)
