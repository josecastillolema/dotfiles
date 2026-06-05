#!/bin/sh

ln -s $(pwd)/../autostart ~/.config/autostart
ln -s $(pwd)/../bash/bash_logout ~/.bash_logout
ln -s $(pwd)/../bash/bashrc.d ~/.bashrc.d
ln -s $(pwd)/../code/keybindings.json ~/.var/app/com.visualstudio.code/config/Code/User/
ln -s $(pwd)/../code/keybindings.json ~/.config/Cursor/User/
ln -s $(pwd)/../code/settings.json ~/.var/app/com.visualstudio.code/config/Code/User/
ln -s $(pwd)/../code/settings.json ~/.config/Cursor/User/
ln -s ~/.var/app/com.visualstudio.code/data/vscode/extensions/ ~/.cursor
ln -s $(pwd)/../containers ~/.config/containers
ln -s $(pwd)/../desktop ~/.local/share/applications
ln -s $(pwd)/../dunst ~/.config/dunst
ln -s $(pwd)/../environment.d ~/.config/environment.d
# Re-run after creating a new Firefox profile
for dir in ~/.mozilla/firefox/*.*/; do
	ln -sf $(pwd)/../firefox/user.js "$dir/user.js"
done
ln -s $(pwd)/../flatpak/overrides ~/.local/share/flatpak
ln -s $(pwd)/../foot ~/.config/foot
ln -s $(pwd)/../ghostty ~/.config/ghostty
ln -s $(pwd)/../gcalcli ~/.config/gcalcli
ln -s $(pwd)/../git ~/.config/git
ln -s $(pwd)/../gnome/texteditor/keyfile ~/.var/app/org.gnome.TextEditor/config/glib-2.0/settings/keyfile
ln -s $(pwd)/../gtk-3.0 ~/.config
ln -s $(pwd)/../helix ~/.var/app/com.helix_editor.Helix/config
ln -s $(pwd)/../icons/hicolor/256x256/apps/co.anysphere.cursor.png ~/.local/share/flatpak/exports/share/icons/hicolor/256x256/apps/co.anysphere.cursor.png
ln -s $(pwd)/../imv ~/.config
ln -s $(pwd)/../mcp.json ~/.cursor
ln -s $(pwd)/../mimeapps.list ~/.config
ln -s $(pwd)/../mpv/mpv.conf ~/.var/app/io.mpv.Mpv/config/mpv/mpv.conf
ln -s $(pwd)/../mpv/input.conf ~/.var/app/io.mpv.Mpv/config/mpv/input.conf
ln -s $(pwd)/../rofi ~/.config/rofi
ln -s $(pwd)/../starship.toml ~/.config/starship.toml
ln -s $(pwd)/../sway ~/.config/sway
ln -s $(pwd)/../swaync ~/.config/swaync
# Copied instead of symlinked: SELinux blocks systemd_logind_t from reading user_home_t.
# Re-run this command after editing systemd/logind.conf.d/lid.conf.
sudo mkdir -p /etc/systemd/logind.conf.d
sudo cp $(pwd)/../systemd/logind.conf.d/lid.conf /etc/systemd/logind.conf.d/lid.conf
# Copied instead of symlinked: SELinux blocks tlp_t from reading user_home_t.
# Re-run this command after editing tlp/01-custom.conf.
sudo cp $(pwd)/../tlp/01-custom.conf /etc/tlp.d/01-custom.conf
ln -s $(pwd)/../wrappers/askpass.sh ~/.local/bin/askpass
mkdir -p ~/.config/tmux
ln -s $(pwd)/../tmux.conf ~/.config/tmux/tmux.conf
ln -s $(pwd)/../transmission/settings.json ~/.var/app/com.transmissionbt.Transmission/config/transmission/settings.json
ln -s $(pwd)/../vim/vimrc ~/.vimrc
ln -s $(pwd)/../vim/vimrc ~/.var/app/io.neovim.nvim/config/nvim/init.vim
ln -s $(pwd)/../vim/vim ~/.vim
ln -s $(pwd)/../vim/vim/ftplugin ~/.var/app/io.neovim.nvim/config/nvim/ftplugin
ln -s $(pwd)/../waybar ~/.config/waybar
mkdir -p ~/.config/wezterm
ln -s $(pwd)/../wezterm.lua ~/.config/wezterm/wezterm.lua
ln -s $(pwd)/../wireplumber ~/.config/wireplumber
ln -s $(pwd)/../xfce4/xfconf ~/.config/xfce4
ln -s $(pwd)/../zathura ~/.config/zathura
# Re-run after creating a new Zen profile
for dir in ~/.zen/*.*/; do
	ln -sf $(pwd)/../zen/user.js "$dir/user.js"
	mkdir -p "$dir/chrome/JS"
	ln -sf $(pwd)/../zen/chrome/utils "$dir/chrome/utils"
	ln -sf $(pwd)/../zen/chrome/JS/openInFirefox.uc.js "$dir/chrome/JS/openInFirefox.uc.js"
done
