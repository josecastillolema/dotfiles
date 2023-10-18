#!/bin/sh

# time and keyboard
timedatectl set-timezone Europe/Madrid # check with timedatectl
localectl set-keymap es                # check with localectl status

# rpm-ostree & baseOS
# - foot will be considered if scrollbar grabable or fast scroll
# - thunar will be considered if preview & dragndrop, ranger i did not get used to
# - openh264 could be removed when moving to flatpak firefox
rpm-ostree install \
   bat \
   fira-code-fonts \
   gnome-terminal-nautilus \
   inotify-tools \
   nautilus \
   openh264 \
   power-profiles-daemon \
   rclone \
   trash-cli \
   virt-manager \
   wdisplays \
   wtype \
   zathura-plugins-all

curl -fsSL https://get.docker.com/rootless | sh
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

# local installs
# /bin: act, clusterctl, crc, kube-burner, kubectl, oc, starship, virtctl
# /go/bin: kind
#oc
curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz | tar -xzf - -C $HOME/bin
#crc
crc config set cpus 8
crc config set memory 18432
crc config set consent-telemetry no
crc config set kubeadmin-password password


# flatpak
#org.freedesktop.appstream-glib to validate flatpak appstreams
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install \
   com.dropbox.Client \
   com.github.eneshecan.WhatsAppForLinux \
   com.google.Chrome \
   com.transmissionbt.Transmission \
   com.visualstudio.code \
   io.mpv.Mpv \
   io.neovim.nvim \
   org.freedesktop.appstream-glib \ 
   org.gnome.Evince \
   org.gnome.FileRoller \
   org.gnome.NautilusPreviewer \
   org.gnome.TextEditor \
   org.gnu.emacs \
   org.libreoffice.LibreOffice \
   org.vim.Vim \
   org.wezfurlong.wezterm
# validate with flatpak override --show
sudo flatpak override --filesystem=home # allow dragndrop?
# validate with: flatpak override --show com.visualstudio.code
# remove them with: sudo flatpak override --reset com.visualstudio.code
sudo flatpak override --env=FLATPAK_ENABLE_SDK_EXT=* com.visualstudio.code
sudo flatpak override --env=FLATPAK_ENABLE_SDK_EXT=* --filesystem=host io.neovim.nvim  # ?
sudo flatpak override --env=FLATPAK_ENABLE_SDK_EXT=* org.gnu.emacs
sudo flatpak override --env=FLATPAK_ENABLE_SDK_EXT=* org.vim.Vim     # ?
sudo flatpak override --env=PATH='/var/home/jose/bin:/var/home/jose/.opam/default/bin:/app/bin:/app/bin:/app/bin:/usr/bin:/home/jose/.var/app/com.visualstudio.code/data/node_modules/bin' com.visualstudio.code
# sudo flatpak override --nosocket=x11 # not tested
# sudo flatpak override --socket=wayland # not tested
# sudo flatpak override --socket=wayland org.mozilla.Thunderbird # per app

# groups
grep -E '^libvirt:' /usr/lib/group >> /etc/group # as root
sudo usermod -aG libvirt $USER
grep -E '^qemu:' /usr/lib/group >> /etc/group    # as root
sudo usermod -aG qemu $USER
sudo setfacl -m u:jose:rwx /var/lib/libvirt/images

# gsettings
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
xdg-settings set default-web-browser firefox.desktop
xdg-mime default imv.desktop image/png
xdg-mime default org.pwmt.zathura.desktop application/pdf

# link the base config
ln -s $(pwd)/bashrc.d ~/.bashrc.d
ln -s $(pwd)/desktop/com.visualstudio.code.desktop ~/.local/share/applications/com.visualstudio.code.desktop
ln -s $(pwd)/docker ~/.config/docker
ln -s $(pwd)/dunst ~/.config/dunst
ln -s $(pwd)/emacs/emacs ~/.emacs
ln -s $(pwd)/emacs/emacs.d ~/.emacs.d
ln -s $(pwd)/foot ~/.config/foot
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/gvimrc ~/.gvimrc
ln -s $(pwd)/mpv.conf ~/.var/app/io.mpv.Mpv/config/mpv/mpv.conf
ln -s $(pwd)/rofi ~/.config/rofi
ln -s $(pwd)/starship.toml ~/.config/starship.toml
ln -s $(pwd)/sway ~/.config/sway
ln -s $(pwd)/systemd/power-monitor.service ~/.config/systemd/user/power-monitor.service
ln -s $(pwd)/systemd/power_monitor.sh ~/.config/systemd/user/power_monitor.sh
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/waybar ~/.config/waybar
ln -s $(pwd)/wezterm.lua ~/.wezterm.lua
ln -s $(pwd)/zathura ~/.config/zathura
