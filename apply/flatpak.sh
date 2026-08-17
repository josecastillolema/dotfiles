#!/bin/sh

#org.freedesktop.appstream-glib to validate flatpak appstreams
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

apps=(
   app.eduroam.geteduroam
   app.zen_browser.zen
   com.dropbox.Client
   com.github.jeromerobert.pdfarranger
   com.github.maoschanz.drawing
   com.github.xournalpp.xournalpp
   com.google.Chrome
   #com.rustdesk.RustDesk
   com.helix_editor.Helix
   #com.hunterwittenborn.Celeste
   com.transmissionbt.Transmission
   com.visualstudio.code
   com.visualstudio.code.tool.podman//stable
   #io.github.seadve.Kooha
   io.mpv.Mpv
   io.neovim.nvim
   #org.ferdium.Ferdium
   #org.flatpak.Builder
   #org.freedesktop.appstream-glib
   org.gnome.Boxes
   org.gnome.Evince
   org.gnome.FileRoller
   #org.gnome.NautilusPreviewer
   org.pwmt.zathura
   #org.gnome.TextEditor
   org.xfce.mousepad
   org.jdownloader.JDownloader
   org.libreoffice.LibreOffice
   #org.virt_manager.virt-manager
   org.mozilla.firefox
   #org.wezfurlong.wezterm
   #us.zoom.Zoom
)

flatpak install --user -y "${apps[@]}"
