#!/bin/sh

# Create parent dirs, remove existing target dir if needed, then symlink.
link() { mkdir -p "$(dirname "$2")"; [ -d "$2" ] && rm -rf "$2"; ln -sf "$1" "$2"; }

link $(pwd)/../autostart ~/.config/autostart
link $(pwd)/../bash/bash_logout ~/.bash_logout
link $(pwd)/../bash/bashrc.d ~/.bashrc.d
link $(pwd)/../code/keybindings.json ~/.var/app/com.visualstudio.code/config/Code/User/keybindings.json
link $(pwd)/../code/settings.json ~/.var/app/com.visualstudio.code/config/Code/User/settings.json
link $(pwd)/../containers ~/.config/containers
link $(pwd)/../crc.json ~/.crc/crc.json
link $(pwd)/../desktop ~/.local/share/applications
link $(pwd)/../dunst ~/.config/dunst
link $(pwd)/../environment.d ~/.config/environment.d
# Re-run after creating a new Firefox profile
for dir in ~/.mozilla/firefox/*.*/; do
	link $(pwd)/../firefox/user.js "$dir/user.js"
done
link $(pwd)/../flatpak/overrides ~/.local/share/flatpak/overrides
# WORKAROUND: remove once https://codeberg.org/dnkl/fcft/src/branch/colrv1 is merged
link $(pwd)/../fontconfig ~/.config/fontconfig
link $(pwd)/../icons/hicolor/256x256/apps/co.anysphere.cursor.png ~/.local/share/flatpak/exports/share/icons/hicolor/256x256/apps/co.anysphere.cursor.png
link $(pwd)/../foot ~/.config/foot
link $(pwd)/../ghostty ~/.config/ghostty
link $(pwd)/../gcalcli ~/.config/gcalcli
link $(pwd)/../git ~/.config/git
link $(pwd)/../gnome/texteditor/keyfile ~/.var/app/org.gnome.TextEditor/config/glib-2.0/settings/keyfile
link $(pwd)/../mousepad/keyfile ~/.var/app/org.xfce.mousepad/config/glib-2.0/settings/keyfile
link $(pwd)/../gtk-3.0 ~/.config/gtk-3.0
link $(pwd)/../helix ~/.var/app/com.helix_editor.Helix/config
link $(pwd)/../imv ~/.config/imv
link $(pwd)/../mimeapps.list ~/.config/mimeapps.list
link $(pwd)/../mpv/mpv.conf ~/.var/app/io.mpv.Mpv/config/mpv/mpv.conf
link $(pwd)/../mpv/input.conf ~/.var/app/io.mpv.Mpv/config/mpv/input.conf
link $(pwd)/../rofi ~/.config/rofi
link $(pwd)/../starship.toml ~/.config/starship.toml
link $(pwd)/../sway ~/.config/sway
link $(pwd)/../swaync ~/.config/swaync
# Copied instead of symlinked: SELinux blocks systemd_logind_t from reading user_home_t.
# Re-run this command after editing systemd/logind.conf.d/lid.conf.
sudo mkdir -p /etc/systemd/logind.conf.d
sudo cp $(pwd)/../systemd/logind.conf.d/lid.conf /etc/systemd/logind.conf.d/lid.conf
# Copied instead of symlinked: SELinux blocks tlp_t from reading user_home_t.
# Re-run this command after editing tlp/01-custom.conf.
sudo cp $(pwd)/../tlp/01-custom.conf /etc/tlp.d/01-custom.conf
link $(pwd)/../wrappers/askpass ~/.local/bin/askpass
link $(pwd)/../wrappers/autofirma ~/.local/bin/autofirma
link $(pwd)/../tmux.conf ~/.config/tmux/tmux.conf
link $(pwd)/../transmission/settings.json ~/.var/app/com.transmissionbt.Transmission/config/transmission/settings.json
link $(pwd)/../vim/vimrc ~/.vimrc
link $(pwd)/../vim/vimrc ~/.var/app/io.neovim.nvim/config/nvim/init.vim
link $(pwd)/../vim/vim ~/.vim
link $(pwd)/../vim/vim/ftplugin ~/.var/app/io.neovim.nvim/config/nvim/ftplugin
link $(pwd)/../waybar ~/.config/waybar
link $(pwd)/../wezterm.lua ~/.config/wezterm/wezterm.lua
link $(pwd)/../wireplumber ~/.config/wireplumber
link $(pwd)/../xfce4/xfconf ~/.config/xfce4/xfconf
link $(pwd)/../zathura ~/.config/zathura
# Re-run after creating a new Zen profile
for dir in ~/.zen/*.*/; do
	link $(pwd)/../zen/user.js "$dir/user.js"
	link $(pwd)/../zen/chrome/utils "$dir/chrome/utils"
	link $(pwd)/../zen/chrome/JS/openInFirefox.uc.js "$dir/chrome/JS/openInFirefox.uc.js"
done
