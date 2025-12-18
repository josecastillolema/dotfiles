if [ -f /run/.toolboxenv ] || [ ! -z $FLATPAK_ID ]; then
   if [ -f /run/.toolboxenv ]; then
      source /run/.containerenv
      printf "\033]777;container;pop;;\033\\"
      builtin cd ${PWD#/var}
      export PATH="$PATH:~/.local/bin/toolbox"
   fi
   if [ ! -z $FLATPAK_ID ]; then
      #alias opam='flatpak-spawn --host $HOME/bin/opam'
      alias toolbox='flatpak-spawn --host toolbox'
   fi
   export CONTAINER_ENGINE=podman-remote # for openshift/release
   export RAMALAMA_CONTAINER_ENGINE=podman-remote # for ramalama
   alias cat='flatpak-spawn --host bat -p -P'
   alias code='flatpak-spawn --host flatpak run com.visualstudio.code'
   #alias emacs='flatpak-spawn --host flatpak run org.gnu.emacs'
   alias fd='flatpak-spawn --host fd'
   alias flatpak='flatpak-spawn --host flatpak'
   #alias jq='flatpak-spawn --host jq'   # need the real one for kind.sh
   alias locate='flatpak-spawn --host locate'
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
      PATH=$(echo "$PATH" | sed -e 's/\/home\/jose\/bin://')
      unalias code
      unset CAML_LD_LIBRARY_PATH
      unset OCAML_TOPLEVEL_PATH
      unset OPAM_SWITCH_PREFIX
      unset MANPATH
      #export CAML_LD_LIBRARY_PATH=/usr/local/lib/ocaml:/usr/local/lib/ocaml/stublibs:/usr/local/lib/ocaml/lib
   fi
fi

