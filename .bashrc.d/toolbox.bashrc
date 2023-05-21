if [ -f /run/.toolboxenv ]; then
    source /run/.containerenv
    printf "\033]777;container;pop;;\033\\"
    cd ${PWD#/var}
    export PATH="$PATH:~/.local/bin/toolbox"
    alias podman='flatpak-spawn --host podman'
    alias open='flatpak-spawn --host xdg-open'
    alias code='flatpak-spawn --host flatpak run com.visualstudio.code'
    if [[ $name = "ocaml" ]]; then
        test -r /var/home/jose/.opam/opam-init/init.sh && . /var/home/jose/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
    fi
fi

