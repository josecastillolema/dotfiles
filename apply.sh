#!/bin/sh

# rpm-ostree & baseOS
rpm-ostree install ranger rclone vagrant-libvirt vim-enhanced virt-manager wdisplays zathura-plugins-all
curl -fsSL https://get.docker.com/rootless | sh
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install com.google.Chrome com.transmissionbt.Transmission com.visualstudio.code io.github.mimbrero.WhatsAppDesktop org.freedesktop.Sdk.Extension.golang org.libreoffice.LibreOffice org.videolan.VLC com.dropbox.Client org.gnome.TextEditor
flatpak override --env=PATH=/app/bin:/usr/bin:/usr/lib/sdk/golang/bin --env=GOROOT=/usr/lib/sdk/golang --env=GOPATH=$HOME/go com.visualstudio.code

# groups
grep -E '^libvirt:' /usr/lib/group >> /etc/group
usermod -aG libvirt username
grep -E '^qemu:' /usr/lib/group >> /etc/group
usermod -aG qemu username
sudo setfacl -m u:jose:rwx /var/lib/libvirt/images

# gsettings
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5

# xdg
# find mimetype with file -i or xdg-mime query filetype 
xdg-settings set default-web-browser com.google.Chrome.desktop
xdg-mime default imv.desktop image/png
xdg-mime default org.pwmt.zathura.desktop application/pdf

# link the base config
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.bashrc.d ~/.bashrc.d
ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/.config/sway ~/.config/sway
ln -s $(pwd)/.config/waybar ~/.config/waybar
ln -s $(pwd)/.config/foot ~/.config/foot
ln -s $(pwd)/.config/zathura ~/.config/zathura
