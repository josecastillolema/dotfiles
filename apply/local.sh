#!/bin/sh

# time and keyboard
#Validate with: "timedatectl"
sudo timedatectl set-timezone Europe/Madrid
sudo timedatectl set-ntp true
localectl set-keymap es                # check with localectl status
systemctl enable --now --user podman.socket

# local installs
# .local/bin: act, clusterctl, crc, kube-burner, kubectl, oc, rg, starship, uv, virtctl
mkdir -p ~/.local/bin
#oc
curl https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz | tar -xzf - -C $HOME/.local/bin
#crc
curl -L https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz | tar -xJf - --strip-components=1 -C $HOME/.local/bin --wildcards '*/crc'
#rg (neovim dependency, installed in ~/.local/bin because the flatpak cannot access /usr/bin)
RG_VERSION=$(curl -sI https://github.com/BurntSushi/ripgrep/releases/latest | grep -i location | sed 's|.*/||' | tr -d '\r')
curl -sL "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz" | tar -xzf - --strip-components=1 -C $HOME/.local/bin --wildcards '*/rg'
#go
GO_VERSION=$(curl -sL 'https://go.dev/dl/?mode=json' | python3 -c "import sys,json; print(json.load(sys.stdin)[0]['version'])")
mkdir -p ~/.local/bin/go
curl -sL "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz" | tar -xzf - -C ~/.local/bin/go
mv ~/.local/bin/go/go ~/.local/bin/go/${GO_VERSION}
ln -sfn ~/.local/bin/go/${GO_VERSION} ~/.local/bin/go/latest
# /go/bin: kind
~/.local/bin/go/latest/bin/go install sigs.k8s.io/kind@latest
# starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/.local/bin
# uv
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install 3.14
ln -sf ~/.local/bin/python3.14 ~/.local/bin/python
# node/npm/npx
curl -fsSL "https://nodejs.org/dist/latest/$(curl -fsSL https://nodejs.org/dist/latest/SHASUMS256.txt | grep -o 'node-v[0-9.]*-linux-x64\.tar\.xz' | head -1)" | tar -xJ --strip-components=1 -C ~/.local
# claude code
curl -fsSL https://claude.ai/install.sh | bash

# WORKAROUND: foot/fcft does not support COLRv1 emoji. Install the old CBDT version.
# Remove once https://codeberg.org/dnkl/fcft/src/branch/colrv1 is merged.
mkdir -p ~/.local/share/fonts
curl -sL -o ~/.local/share/fonts/NotoColorEmoji.ttf https://raw.githubusercontent.com/googlefonts/noto-emoji/main/fonts/NotoColorEmoji.ttf
fc-cache -f ~/.local/share/fonts

# dconf settings (font, icon theme, color scheme, button layout)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
dconf load / < "$SCRIPT_DIR/../dconf/settings.ini"

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
xdg-mime default imv-thunar.desktop image/png
#xdg-mime default org.pwmt.zathura.desktop application/pdf

# Update icon cache after dropbox icons
# Not needed anymore thanks to papirus-icon-theme
#gtk-update-icon-cache ~/.local/share/flatpak/exports/share/icons/hicolor
