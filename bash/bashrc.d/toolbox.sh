if [ -f /run/.toolboxenv ] || [ ! -z $FLATPAK_ID ]; then
   if [ -f /run/.toolboxenv ]; then
      source /run/.containerenv
      [[ -t 1 ]] && printf "\033]777;container;pop;;\033\\"
      builtin cd ${PWD#/var}
      export PATH="$PATH:~/.local/bin/toolbox"
      shopt -s huponexit
   fi
   if [ ! -z $FLATPAK_ID ]; then
      #alias opam='flatpak-spawn --host $HOME/bin/opam'
      alias toolbox='flatpak-spawn --host toolbox'
   fi
   export CONTAINER_ENGINE=podman-remote # for openshift/release
   export RAMALAMA_CONTAINER_ENGINE=podman-remote # for ramalama
   function cd {
     builtin cd "$@" && flatpak-spawn --host lsd --icon always
   }
   alias cat='flatpak-spawn --host bat -p -P'
   alias code='flatpak-spawn --host flatpak run com.visualstudio.code'
   #alias emacs='flatpak-spawn --host flatpak run org.gnu.emacs'
   alias fd='flatpak-spawn --host fd'
   export FZF_DEFAULT_COMMAND="flatpak-spawn --host fd --type f"
   alias flatpak='flatpak-spawn --host flatpak'
   #alias jq='flatpak-spawn --host jq'   # need the real one for kind.sh
   alias locate='flatpak-spawn --host locate'
   alias ls='flatpak-spawn --host lsd --icon always'
   alias lsd='flatpak-spawn --host lsd --icon always'
   alias open='flatpak-spawn --host xdg-open'
   #alias pip='flatpak-spawn --host ~/.local/bin/pip'
   #alias podman='flatpak-spawn --host podman'
   alias podman='podman-remote'
   #alias python=python3
   alias rm=trash
   alias rm2=/usr/bin/rm
   #alias trash='flatpak-spawn --host trash'
   alias updatedb='flatpak-spawn --host updatedb'
   alias vi='flatpak-spawn --host flatpak --env=TERM=xterm-256color run io.neovim.nvim'
   #alias vimdiff='flatpak-spawn --host vimdiff'
   #if [[ $name = fedora-toolbox-* ]]; then
   #   . /usr/share/bash-completion/completions/podman
   #   complete -o default -F __start_podman p
   #fi
   # Lazy-load completions for host commands used via flatpak-spawn
   _host_load_completion() {
       local alias_name=$1 host_cmd=$2
       complete -r "$alias_name" 2>/dev/null

       local comp
       comp=$(flatpak-spawn --host bash -c "${host_cmd} completion bash 2>/dev/null")
       [[ -z "$comp" ]] && comp=$(flatpak-spawn --host cat "/usr/share/bash-completion/completions/${host_cmd}" 2>/dev/null)
       [[ -z "$comp" ]] && return

       if [[ "$comp" =~ complete\ -C\ [^\ ]+\ ([a-zA-Z0-9_-]+) ]]; then
           local completer
           completer=$(sed -n "s/^complete -C \([^ ]*\) .*/\1/p" <<< "$comp")
           eval "_host_completer_${alias_name//-/_}() {
               COMPREPLY=(\$(COMP_LINE=\"\$COMP_LINE\" COMP_POINT=\"\$COMP_POINT\" flatpak-spawn --host ${completer} 2>/dev/null))
           }"
           complete -F "_host_completer_${alias_name//-/_}" "$alias_name"
           return 124
       fi

       eval "$comp"

       if [[ "$alias_name" != "$host_cmd" ]]; then
           local reg
           reg=$(complete -p "$host_cmd" 2>/dev/null) && {
               complete -r "$host_cmd" 2>/dev/null
               eval "${reg% *} $alias_name"
           }
       fi
       return 124
   }

   _host_register_completions() {
       local alias_name host_cmd func
       while read -r alias_name host_cmd; do
           [[ "$host_cmd" == "flatpak" && "$alias_name" != "flatpak" ]] && continue
           # Don't override fzf's fuzzy file completion for file-oriented commands
           [[ $(complete -p "$alias_name" 2>/dev/null) == *_fzf_* ]] && continue
           func="_host_comp_${alias_name//-/_}"
           eval "${func}() { _host_load_completion '${alias_name}' '${host_cmd}'; }"
           complete -F "$func" "$alias_name"
       done < <(alias -p | sed -n "s/^alias \([a-zA-Z0-9_-]*\)='flatpak-spawn --host \([a-zA-Z0-9_.-]*\).*/\1 \2/p")
   }
   _host_register_completions
   unset -f _host_register_completions

   if [[ $name = "flutter" ]]; then
      export CHROME_EXECUTABLE=/usr/bin/chromium-browser
   fi
   if [[ $name = "ocaml" ]] || [[ $name = "mirage" ]] || [[ $name = "ocaml-min" ]]; then
      eval $(opam env --root /opt/opam --set-root)
      if [ ! -O /opt/opam ]; then
         sudo chown -R jose:jose /opt/opam/
         opam var --switch ${OPAM_SWITCH_PREFIX##*/} user=$USER
         opam var --switch ${OPAM_SWITCH_PREFIX##*/} group=$USER
      fi
      unalias code
   fi
   if [[ $name = "ocaml-bin" ]]; then
      PATH=$(echo "$PATH" | sed -e 's/\/var\/home\/jose\/.opam\/default\/bin://')
      PATH=$(echo "$PATH" | sed -e 's/\/var\/home\/jose\/.opam\/4.14.1\/bin://')
      PATH=$(echo "$PATH" | sed -e 's/\/home\/jose\/.local\/bin://')
      unalias code
      unset CAML_LD_LIBRARY_PATH
      unset OCAML_TOPLEVEL_PATH
      unset OPAM_SWITCH_PREFIX
      unset MANPATH
      #export CAML_LD_LIBRARY_PATH=/usr/local/lib/ocaml:/usr/local/lib/ocaml/stublibs:/usr/local/lib/ocaml/lib
   fi
fi

