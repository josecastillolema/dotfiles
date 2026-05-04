#!/bin/bash
# Launch Zen Browser from a writable wrapper directory so that
# fx-autoconfig can load userChrome.js scripts.
#
# The Flatpak install dir (/app/zen/) is read-only, but autoconfig
# requires config.js next to the binary. This script rebuilds a
# wrapper dir with symlinks + copied binaries on every launch,
# keeping it in sync after Flatpak updates.

WRAPPER=$HOME/.local/share/zen-wrapper
AUTOCONFIG=$HOME/dev/dotfiles/zen/autoconfig

mkdir -p "$WRAPPER/defaults/pref"

for f in /app/zen/*; do
  name=$(basename "$f")
  case "$name" in
    defaults|zen|zen-bin) ;;
    *) ln -sf "$f" "$WRAPPER/$name" ;;
  esac
done

cp -f /app/zen/zen "$WRAPPER/zen"
cp -f /app/zen/zen-bin "$WRAPPER/zen-bin"

cp -f "$AUTOCONFIG/config.js" "$WRAPPER/"
cp /app/zen/defaults/pref/* "$WRAPPER/defaults/pref/"
cp -f "$AUTOCONFIG/defaults/pref/config-prefs.js" "$WRAPPER/defaults/pref/"

export TMPDIR=$XDG_CACHE_HOME/tmp
exec "$WRAPPER/zen" --name app.zen_browser.zen -P "Default (release)" "$@"
