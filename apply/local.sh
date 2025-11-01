#!/bin/sh

# time and keyboard
#Validate with: "timedatctl"
#sudo timedatectl set-timezone Europe/Madrid
sudo timedatectl set-ntp true
localectl set-keymap es                # check with localectl status
systemctl enable --now --user podman.socket

curl -fsSL https://get.docker.com/rootless | sh
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

# local installs
# /bin: act, clusterctl, crc, kube-burner, kubectl, oc, rg, starship, virtctl
#oc
curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz | tar -xzf - -C $HOME/bin
#crc
wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
crc config set cpus 8
crc config set memory 18432
crc config set consent-telemetry no
crc config set kubeadmin-password password
# /go/bin: kind
go install sigs.k8s.io/kind@v0.20.0
# .local/bin: pip ansible
python -m ensurepip --upgrade
python -m pip install --user ansible

# gsettings
gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono Bold 11'  # Default is 'Cantarell 11'
gsettings set org.gnome.desktop.interface icon-theme Papirus
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

# Update icon cache after dropbox icons
# Not needed anymore thanks to papirus-icon-theme
#gtk-update-icon-cache ~/.local/share/flatpak/exports/share/icons/hicolor