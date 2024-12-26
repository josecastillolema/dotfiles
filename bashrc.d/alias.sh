alias ....='cd ../../..'
alias ...='cd ../../'
alias ..='cd ..'
alias -- -='cd -'
alias c=cat
alias cat='bat -p -P --tabs 2'
alias cd--='cd --'
alias cd-='cd -'
alias cd..='cd ..'
alias cn='cat -n'
alias chrome='flatpak run com.google.Chrome --ozone-platform=wayland'
alias code='flatpak run com.visualstudio.code'
alias d=docker
#alias e='emacs -nw'
#alias emacs='flatpak run org.gnu.emacs'
alias ferdium='flatpak run --socket=wayland --nosocket=x11 org.ferdium.Ferdium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-memory-buffer-video-frames'
alias g=grep
alias gi=grepi
alias grep='grep --color'
alias grepi='grep --color -i'
alias grepri='grep --color -ri'
alias gri=grepri
#alias gvim='flatpak run org.vim.Vim'
alias h=head
alias hx=com.helix_editor.Helix
alias k=kubectl
alias kcli='podman run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir quay.io/karmab/kcli'
alias kclishell='podman run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir --entrypoint=/bin/bash quay.io/karmab/kcli'
alias kcliweb='podman run -p 9000:9000 --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir --entrypoint=/usr/bin/kweb quay.io/karmab/kcli'
alias l='ls'
alias la='ls -A'
alias ll='ls -lFh'
alias lla='ll -A'
alias lal='ll -A'
alias ls='ls --color -B'
alias o=open
alias open=xdg-open
alias p=podman
alias rm=trash
alias rm2=/usr/bin/rm
alias t=toolbox
alias vi='io.neovim.nvim'
alias v=vi
alias vim=vi
alias vi2=/usr/bin/vi
alias watch='watch '
