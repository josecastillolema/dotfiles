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

# Lazy-load completions for commands aliased to 'toolbox run'.
# On first TAB, fetches the real completion from inside the toolbox,
# evals it (cached in-memory for the session), then retries.
if [ ! -f /run/.toolboxenv ]; then
    _toolbox_load_completion() {
        local cmd=$1
        complete -r "$cmd" 2>/dev/null

        local comp
        comp=$(toolbox run "$cmd" completion bash 2>/dev/null)
        [[ -z "$comp" ]] && comp=$(toolbox run cat "/usr/share/bash-completion/completions/$cmd" 2>/dev/null)
        [[ -z "$comp" ]] && return

        # 'complete -C <binary>' expects an executable, not a multi-word command,
        # so wrap it in a function that forwards through toolbox
        if [[ "$comp" =~ complete\ -C\ [^\ ]+\ ([a-zA-Z0-9_-]+) ]]; then
            local target="${BASH_REMATCH[1]}"
            local completer
            completer=$(sed -n "s/^complete -C \([^ ]*\) .*/\1/p" <<< "$comp")
            eval "_toolbox_completer_${target}() {
                COMPREPLY=(\$(COMP_LINE=\"\$COMP_LINE\" COMP_POINT=\"\$COMP_POINT\" toolbox run ${completer} 2>/dev/null))
            }"
            complete -F "_toolbox_completer_${target}" "$target"
            return 124
        fi

        eval "$comp"
        return 124
    }

    _toolbox_register_completions() {
        local cmd func
        while IFS= read -r cmd; do
            func="_toolbox_comp_${cmd//-/_}"
            eval "${func}() { _toolbox_load_completion '${cmd}'; }"
            complete -F "$func" "$cmd"
        done < <(alias -p | sed -n "s/^alias \([a-zA-Z0-9_-]*\)='toolbox run .*/\1/p")
    }
    _toolbox_register_completions
    unset -f _toolbox_register_completions
fi
