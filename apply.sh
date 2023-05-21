#!/bin/sh

# rpm-ostree
rpm-ostree install ranger
 
# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install com.google.Chrome com.transmissionbt.Transmission com.visualstudio.code io.github.mimbrero.WhatsAppDesktop org.freedesktop.Sdk.Extension.golang org.libreoffice.LibreOffice org.videolan.VLC

# groups
# grep -E '^libvirt:' /usr/lib/group >> /etc/group
# usermod -aG libvirt username
# grep -E '^qemu:' /usr/lib/group >> /etc/group
# usermod -aG qemu username
# sudo setfacl -m u:jose:rwx /var/lib/libvirt/images

# gsettings
gsettings set org.gnome.desktop.interface text-scaling-factor 1.5

# xdg
# find mimetype with file -i
xdg-settings set default-web-browser com.google.Chrome.desktop
xdg-mime default imv.desktop image/png
xdg-mime default org.pwmt.zathura.desktop application/pdf

# backup any old config files
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.old
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.old
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.old
[ -f ~/.gitconfig ] && mv ~/.gitconfig ~/.gitconfig.old
[ -f ~/.config/sway/config.d/sway.conf ] && mv ~/.config/sway/config.d/sway.conf ~/.config/sway/config.d/sway.conf.old

# install Vundle
[ -d ~/.vim ] || mkdir ~/.vim
[ -d ~/.vim/bundle/Vundle.vim ] || \
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# link my base config
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.bashrc.d $HOME/.bashrc.d
ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/.config/sway/config.d ~/.config/sway/config.d
ln -s $(pwd)/.config/waybar ~/.config/waybar
ln -s $(pwd)/.config/foot/foot.ini ~/.config/foot/foot.ini

# install plugins with Vundle
vim +PluginInstall +qall
