if [ -f /run/.toolboxenv ]; then
    source /run/.containerenv
    printf "\033]777;container;pop;;\033\\"
    builtin cd ${PWD#/var}
    export PATH="$PATH:~/.local/bin/toolbox"
    alias cat='flatpak-spawn --host bat -p -P'
    #alias jq='flatpak-spawn --host jq'   # need the real one for kind.sh
    alias locate='flatpak-spawn --host locate'
    alias open='flatpak-spawn --host xdg-open'
    alias podman='flatpak-spawn --host podman'
    alias updatedb='flatpak-spawn --host updatedb'
    alias vi='flatpak-spawn --host vi'
    alias vimdiff='flatpak-spawn --host vimdiff'
    alias code='flatpak-spawn --host flatpak run --socket=wayland com.visualstudio.code --ozone-platform-hint=wayland'
    if [[ $name = "ocaml" ]]; then
        #test -r /var/home/jose/.opam/opam-init/init.sh && . /var/home/jose/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
        [ ! -d "$HOME/.opam" ] && ln -s /usr/share/opam/.opam ~/.opam
        eval $(opam env)
        unalias code
    fi
fi

