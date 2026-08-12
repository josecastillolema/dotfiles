# Reload git completion (fzf overrides it with _fzf_path_completion)
_comp_load git 2>/dev/null

source <(kubectl completion bash)
complete -o default -F __start_kubectl k

source <(oc completion bash)

#if [ ! -f /run/.toolboxenv ]; then
#  . /usr/share/bash-completion/completions/podman
#  complete -o default -F __start_podman p
#fi

#export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
#source <(carapace _carapace)
