#!/bin/sh

# gvfs-mtp for Android file sharing
# java for autofirma
# nodejs-npm for Claude
# virt-manager until https://github.com/crc-org/crc/issues/3541
rpm-ostree install \
   bat \
   fd-find \
   fzf \
   globalprotect-openconnect \
   #gnome-terminal-nautilus \
   gvfs-mtp \
   java \
   jetbrains-mono-fonts \
   #nautilus \
   nodejs-npm \
   papirus-icon-theme \
   #rclone \
   SwayNotificationCenter \
   tlp \
   trash-cli \
   virt-manager \
   #wdisplays \
   #wl-mirror \
   wtype
   zathura-plugins-all

# Use "rpm-ostree override reset" to undo overrides
rpm-ostree override remove firefox-langpacks firefox dunst #tuned tuned-switcher tuned-ppd

# tlp - Use tlp-stat -s to check status
systemctl start --enable tlp

# virt-manager - groups
grep -E '^libvirt:' /usr/lib/group >> /etc/group # as root
sudo usermod -aG libvirt $USER
grep -E '^qemu:' /usr/lib/group >> /etc/group    # as root
sudo usermod -aG qemu $USER
sudo setfacl -m u:jose:rwx /var/lib/libvirt/images

# Remove original imv config to avoid errors
sudo rm /etc/imv_config

#systemctl --user start power-monitor --enable
