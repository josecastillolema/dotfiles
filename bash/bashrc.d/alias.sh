alias ....='cd ../../..'
alias ...='cd ../../'
alias ..='cd ..'
# alias -- -='cd -' Causing problems with Claude
alias c=cat
alias cat='bat -p -P --tabs 2'
alias cat2='/usr/bin/cat'
alias cd--='cd --'
alias cd-='cd -'
alias cd..='cd ..'
#alias claude='http_proxy= https_proxy= claude'
alias cn='cat -n'
alias chrome='com.google.Chrome --ozone-platform=wayland'
alias code='com.visualstudio.code'
alias cursor='~/bin/Cursor.AppImage --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations'
alias d=docker
#alias e='emacs -nw'
#alias emacs='org.gnu.emacs'
alias f=flatpak
alias ferdium='flatpak run --socket=wayland --nosocket=x11 org.ferdium.Ferdium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-memory-buffer-video-frames'
alias g=grep
alias gi=grepi
alias gr=grepr
alias grep='grep --color'
alias grepi='grep --color -i'
alias grepr='grep --color -r'
alias grepri='grep --color -ri'
alias gri=grepri
#alias gvim='org.vim.Vim'
alias h=head
alias hx=com.helix_editor.Helix
alias k=kubectl
alias kcli='docker run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir quay.io/karmab/kcli'
alias kclishell='docker run --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir --entrypoint=/bin/bash quay.io/karmab/kcli'
alias kcliweb='podman run -p 9000:9000 --net host -it --rm --security-opt label=disable -v $HOME/.ssh:/root/.ssh -v $HOME/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir --entrypoint=/usr/bin/kweb quay.io/karmab/kcli'
alias ls='lsd --icon always'
alias l='ls'
alias la='ls -A'
alias ll='ls -lFh --git'
alias lla='ll -A'
alias lal='ll -A'
#alias ls='ls --color -B'
alias o=open
alias open=xdg-open
alias p=podman
alias rm2=/usr/bin/rm
alias t='toolbox enter'
alias vi='io.neovim.nvim'
alias v=vi
alias vim=vi
alias vi2=/usr/bin/vi
alias venv='python -m venv .'
alias watch='watch '
if [ ! -f /run/.toolboxenv ]; then
  #alias claude='toolbox run claude'
  alias dnf='toolbox run dnf'
  alias gh='toolbox run gh'
  alias make='toolbox run make'
  alias pass='toolbox run pass'
  alias rm='toolbox run trash'
  alias shellcheck='toolbox run shellcheck -S warning'
  alias telnet='toolbox run telnet'
  alias wdisplays='toolbox run wdisplays'
  alias wf-recorder='toolbox run bash -c "wf-recorder -g \"\$(flatpak-spawn --host slurp)\""'
  alias wl-mirror='toolbox run wl-mirror'
fi
