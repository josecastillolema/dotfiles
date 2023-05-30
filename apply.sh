#!/bin/sh

# time and keyboard
timedatectl set-timezone Europe/Madrid # check with timedatectl
localectl set-keymap es                # check with localectl status

# rpm-ostree & baseOS
# - will consider foot if scrollbar grabable or fast scroll
# - will consider thunar if preview & dragndrop, ranger i did not get used to
rpm-ostree install gnome-terminal-nautilus nautilus rclone vagrant-libvirt vim-enhanced virt-manager wdisplays zathura-plugins-all
curl -fsSL https://get.docker.com/rootless | sh
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install com.google.Chrome com.transmissionbt.Transmission com.visualstudio.code io.github.mimbrero.WhatsAppDesktop org.freedesktop.Sdk.Extension.golang org.libreoffice.LibreOffice org.videolan.VLC com.dropbox.Client org.gnome.TextEditor org.gnome.NautilusPreviewer
sudo flatpak override --env=PATH=/app/bin:/usr/bin:/usr/lib/sdk/golang/bin --env=GOROOT=/usr/lib/sdk/golang --env=GOPATH=$HOME/go com.visualstudio.code
sudo flatpak override --filesystem=home # allow dragndrop

# groups
grep -E '^libvirt:' /usr/lib/group >> /etc/group
usermod -aG libvirt $USER
grep -E '^qemu:' /usr/lib/group >> /etc/group
usermod -aG qemu $USER
sudo setfacl -m u:jose:rwx /var/lib/libvirt/images

# gsettings
gsettings set org.gnome.desktop.interface text-scaling-factor 1.3
gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'

# xdg
# find mimetype with file -i or xdg-mime query filetype 
xdg-settings set default-web-browser com.google.Chrome.desktop
xdg-mime default imv.desktop image/png
xdg-mime default org.pwmt.zathura.desktop application/pdf

# link the base config
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/bashrc.d ~/.bashrc.d
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/sway ~/.config/sway
ln -s $(pwd)/waybar ~/.config/waybar
ln -s $(pwd)/foot ~/.config/foot
ln -s $(pwd)/zathura ~/.config/zathura
ln -s $(pwd)/starship.toml ~/.config/starship.toml
