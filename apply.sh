#!/bin/sh

# time and keyboard
#Validate with: "timedatctl"
#sudo timedatectl set-timezone Europe/Madrid
sudo timedatectl set-ntp true
localectl set-keymap es                # check with localectl status

# rpm-ostree & baseOS
# java for autofirma
rpm-ostree install \
   bat \
   fd-find \
   fzf \
   globalprotect-openconnect \
   gnome-terminal-nautilus \
   inotify-tools \
   java \
   jetbrains-mono-fonts \
   nautilus \
   power-profiles-daemon \
   rclone \
   tailscale \
   trash-cli \
   virt-manager \
   wdisplays \
   wtype
   # zathura-plugins-all

# Use "rpm-ostree override reset" to undo overrides
rpm-ostree override remove firefox-langpacks firefox

curl -fsSL https://get.docker.com/rootless | sh
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

# local installs
# /bin: act, clusterctl, crc, kube-burner, kubectl, oc, rg, starship, virtctl
#oc
curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz | tar -xzf - -C $HOME/bin
#crc
crc config set cpus 8
crc config set memory 18432
crc config set consent-telemetry no
crc config set kubeadmin-password password
# /go/bin: kind
go install sigs.k8s.io/kind@v0.20.0
# .local/bin: pip ansible
python -m ensurepip --upgrade
python -m pip install --user ansible

# flatpak
#org.freedesktop.appstream-glib to validate flatpak appstreams
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -u \
   com.dropbox.Client \
   com.github.jeromerobert.pdfarranger \
   com.github.maoschanz.drawing \
   com.github.xournalpp.xournalpp \
   com.google.Chrome \
   com.rustdesk.RustDesk \
   com.transmissionbt.Transmission \
   com.visualstudio.code \
   com.visualstudio.code.tool.podman \
   io.github.seadve.Kooha \
   io.mpv.Mpv \
   io.neovim.nvim \
   org.ferdium.Ferdium \
   org.freedesktop.appstream-glib \
   org.gnome.Evince \
   org.gnome.FileRoller \
   org.gnome.NautilusPreviewer \
   org.gnome.TextEditor \
   org.jdownloader.JDownloader \
   org.libreoffice.LibreOffice \
   org.mozilla.firefox \
   org.wezfurlong.wezterm \
   us.zoom.Zoom

# validate with: "flatpak override --user --show"
flatpak override --user --filesystem=home;/tmp # allow dragndrop?
                                        # CAUTION this caused to loose all flatpak firefox preferences
# validate with: "flatpak override --user --show com.visualstudio.code"
# remove them with: "flatpak override --user --reset com.visualstudio.code"
#flatpak override --user --env=FLATPAK_ENABLE_SDK_EXT=* com.visualstudio.code
#flatpak override --user --env=FLATPAK_ENABLE_SDK_EXT=* --filesystem=host io.neovim.nvim  # ?
#flatpak override --user --env=FLATPAK_ENABLE_SDK_EXT=* io.neovim.nvim
#flatpak override --user --filesystem=/run/user/1000/docker.sock com.visualstudio.code
flatpak override --user --socket=wayland --socket=fallback-x11 --env=ELECTRON_OZONE_PLATFORM_HINT=auto com.visualstudio.code
flatpak override --user --filesystem=/tmp com.visualstudio.code
flatpak override --user --filesystem=xdg-run/podman:ro com.visualstudio.code
flatpak override --user --env=PATH='/app/bin:/app/bin:/app/bin:/usr/bin:/app/tools/podman/bin:/home/jose/.var/app/com.visualstudio.code/data/node_modules/bin:/home/jose/.local/bin:/home/jose/bin:/home/jose/.opam/default/bin:/home/jose/go/bin:/home/jose/go/go-1.21.3/bin' com.visualstudio.code
#flatpak override --user --env=PATH='/app/bin:/usr/bin:/home/jose/.local/bin:/home/jose/bin:/home/jose/.opam/default/bin:/home/jose/go/bin:/home/jose/go/go-1.21.3/bin' com.visualstudio.code
flatpak override --user --env=PATH='/home/jose/.local/bin:/home/jose/bin:/home/jose/.opam/default/bin:/home/jose/go/bin:/home/jose/go/go-1.21.3/bin:/app/bin:/usr/bin:/home/jose/.var/app/io.neovim.nvim/data/node/bin:/home/jose/.var/app/io.neovim.nvim/data/cargo/bin:/home/jose/.var/app/io.neovim.nvim/data/python/bin:/home/jose/.var/app/io.neovim.nvim/data/gem/ruby/3.2.0/bin' io.neovim.nvim
#flatpak override --user --env=PATH='/home/jose/.local/bin:/home/jose/bin:/home/jose/.opam/default/bin:/home/jose/go/bin:/home/jose/go/go-1.21.3/bin:/app/bin:/usr/bin' io.neovim.nvim
flatpak override --user --env=PATH='/app/bin:/usr/bin:/home/jose/.local/bin:/home/jose/bin:/home/jose/.opam/default/bin:/home/jose/go/bin:/home/jose/go/go-1.21.3/bin' org.gnu.emacs

# groups
grep -E '^libvirt:' /usr/lib/group >> /etc/group # as root
sudo usermod -aG libvirt $USER
grep -E '^qemu:' /usr/lib/group >> /etc/group    # as root
sudo usermod -aG qemu $USER
sudo setfacl -m u:jose:rwx /var/lib/libvirt/images

# gsettings
gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono Bold 11'  # Default is 'Cantarell 11'
#gsettings set org.gnome.desktop.interface text-scaling-factor 1

# gnome-terminal
# commented because switched to wezterm
#gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
#gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
#gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
#setterm -linewrap off

# xdg
# find mimetype with file -i or xdg-mime query filetype
#xdg-settings set default-web-browser com.google.Chrome.desktop
#xdg-settings set default-web-browser firefox.desktop
xdg-settings set default-web-browser org.mozilla.firefox.desktop
xdg-mime default imv.desktop image/png
#xdg-mime default org.pwmt.zathura.desktop application/pdf

# link the base config
ln -s $(pwd)/bashrc.d ~/.bashrc.d
ln -s $(pwd)/containers ~/.config/containers
ln -s $(pwd)/code/keybindings.json ~/.var/app/com.visualstudio.code/config/Code/User/
ln -s $(pwd)/code/settings.json ~/.var/app/com.visualstudio.code/config/Code/User/
ln -s $(pwd)/desktop ~/.local/share/applications
ln -s $(pwd)/docker ~/.config/docker
ln -s $(pwd)/dunst ~/.config/dunst
#ln -s $(pwd)/emacs/emacs ~/.emacs
#ln -s $(pwd)/emacs/emacs.d ~/.emacs.d
ln -s $(pwd)/flatpak/overrides ~/.local/share/flatpak
ln -s $(pwd)/foot ~/.config/foot
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/mpv/mpv.conf ~/.var/app/io.mpv.Mpv/config/mpv/mpv.conf
ln -s $(pwd)/mpv/input.conf ~/.var/app/io.mpv.Mpv/config/mpv/input.conf
ln -s $(pwd)/rofi ~/.config/rofi
ln -s $(pwd)/starship.toml ~/.config/starship.toml
ln -s $(pwd)/sway ~/.config/sway
ln -s $(pwd)/systemd/power-monitor.service ~/.config/systemd/user/power-monitor.service
ln -s $(pwd)/systemd/power_monitor.sh ~/.config/systemd/user/power_monitor.sh
ln -s $(pwd)/tmux.conf ~/.tmux.conf
#ln -s $(pwd)/vim/gvimrc ~/.gvimrc
ln -s $(pwd)/vim/vimrc ~/.vimrc
ln -s $(pwd)/vim/vimrc ~/.var/app/io.neovim.nvim/config/nvim/init.vim
ln -s $(pwd)/vim/vim ~/.vim
ln -s $(pwd)/vim/vim/ftplugin ~/.var/app/io.neovim.nvim/config/nvim/ftplugin
ln -s $(pwd)/waybar ~/.config/waybar
ln -s $(pwd)/wezterm.lua ~/.wezterm.lua
#ln -s $(pwd)/zathura ~/.config/zathura

systemctl --user start power-monitor --enable
