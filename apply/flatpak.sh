#!/bin/sh

#org.freedesktop.appstream-glib to validate flatpak appstreams
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -u \
   app.zen_browser.zen \
   com.dropbox.Client \
   com.github.jeromerobert.pdfarranger \
   com.github.maoschanz.drawing \
   com.github.xournalpp.xournalpp \
   com.google.Chrome \
   #com.rustdesk.RustDesk \
   com.helix_editor.Helix \
   com.hunterwittenborn.Celeste \
   com.transmissionbt.Transmission \
   com.visualstudio.code \
   com.visualstudio.code.tool.podman \
   io.github.seadve.Kooha \
   io.mpv.Mpv \
   io.neovim.nvim \
   org.ferdium.Ferdium \
   org.flatpak.Builder \
   #org.freedesktop.appstream-glib \
   org.gnome.Boxes \
   org.gnome.Evince \
   org.gnome.FileRoller \
   #org.gnome.NautilusPreviewer \
   org.gnome.TextEditor \
   org.jdownloader.JDownloader \
   org.libreoffice.LibreOffice \
   #org.virt_manager.virt-manager \
   org.mozilla.firefox \
   org.wezfurlong.wezterm \
   #us.zoom.Zoom

# validate with: "flatpak override --user --show"
flatpak override --user --filesystem=home;/tmp # allow dragndrop?
                                        # CAUTION this caused to loose all flatpak firefox preferences
# validate with: "flatpak override --user --show com.visualstudio.code"
# remove them with: "flatpak override --user --reset com.visualstudio.code"
#flatpak override --user --env=FLATPAK_ENABLE_SDK_EXT=* com.visualstudio.code
#flatpak override --user --env=FLATPAK_ENABLE_SDK_EXT=* --filesystem=host io.neovim.nvim  # ?
#flatpak override --user --env=FLATPAK_ENABLE_SDK_EXT=* io.neovim.nvim
#flatpak override --user --filesystem=/run/user/1000/docker.sock com.visualstudio.code
flatpak override --user --filesystem=/tmp com.visualstudio.code