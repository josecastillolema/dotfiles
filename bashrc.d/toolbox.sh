if [ -f /run/.toolboxenv ] || [ ! -z $FLATPAK_ID ]; then
   if [ -f /run/.toolboxenv ]; then
      source /run/.containerenv
      printf "\033]777;container;pop;;\033\\"
      builtin cd ${PWD#/var}
      export PATH="$PATH:~/.local/bin/toolbox"
   fi
   alias cat='flatpak-spawn --host bat -p -P'
   alias code='flatpak-spawn --host flatpak run --socket=wayland com.visualstudio.code --ozone-platform-hint=wayland'
   alias emacs='flatpak-spawn --host flatpak run org.gnu.emacs'
   #alias jq='flatpak-spawn --host jq'   # need the real one for kind.sh
   alias locate='flatpak-spawn --host locate'
   alias open='flatpak-spawn --host xdg-open'
   alias podman='flatpak-spawn --host podman'
   alias trash='flatpak-spawn --host trash'
   alias updatedb='flatpak-spawn --host updatedb'
   alias vi='flatpak-spawn --host flatpak --env=TERM=xterm-256color run io.neovim.nvim'
   #alias vimdiff='flatpak-spawn --host vimdiff'
   if [[ $name = "ocaml" ]] || [[ $name = "mirage" ]] || [[ $name = "ocamlmin" ]]; then
      eval $(opam env --root /opt/opam --set-root)
      if [ ! -O /opt/opam ]; then
         sudo chown -R jose:jose /opt/opam/
         opam var --switch ${OPAM_SWITCH_PREFIX##*/} user=$USER
         opam var --switch ${OPAM_SWITCH_PREFIX##*/} group=$USER
      fi
      unalias code
   fi
fi

