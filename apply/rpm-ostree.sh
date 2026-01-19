#!/bin/sh

# - gvfs-mtp for Android file sharing
# - java for autofirma
# - nodejs-npm for claude-code (can we move it to toolbox?)
# - virt-manager until https://github.com/crc-org/crc/issues/3541
#   consider libvirt-daemon-kvm as a lighter alternative
rpm-ostree install \
   bat \
   fd-find \
   fzf \
   globalprotect-openconnect \
   #gnome-terminal-nautilus \
   gvfs-mtp \
   java \
   jetbrains-mono-fonts \
   lsd \
   #nautilus \
   nodejs-npm \
   papirus-icon-theme \
   #rclone \
   SwayNotificationCenter \
   tlp \
   #trash-cli \
   #virt-manager \
   wtype
   zathura-plugins-all

# Use "rpm-ostree override reset" to undo overrides
rpm-ostree override remove firefox-langpacks firefox dunst #tuned tuned-switcher tuned-ppd

# Use newer Intel GPU xe driver instead of i915
# To revert the change if needed: rpm-ostree kargs --delete="i915.force_probe=!9a60" --delete="xe.force_probe=9a60"
rpm-ostree kargs --append="i915.force_probe=!9a60" --append="xe.force_probe=9a60"


# tlp - Use tlp-stat -s to check status
systemctl start --enable tlp

# virt-manager - groups
grep -E '^libvirt:' /usr/lib/group >> /etc/group # as root
sudo usermod -aG libvirt $USER
grep -E '^qemu:' /usr/lib/group >> /etc/group    # as root
sudo usermod -aG qemu $USER
sudo setfacl -m u:$USER:rwx /var/lib/libvirt/images

# Remove original imv config to avoid errors
sudo rm /etc/imv_config

#systemctl --user start power-monitor --enable
