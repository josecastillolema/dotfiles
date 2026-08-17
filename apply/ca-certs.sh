#!/bin/sh
#
# Import host CA certificates into Firefox and Zen Flatpak profiles.
# Flatpak browsers don't trust host CAs via p11-kit for TLS verification:
# https://github.com/flatpak/flatpak/issues/2721
# https://bugzilla.mozilla.org/show_bug.cgi?id=1762854

ANCHOR_DIR="/etc/pki/ca-trust/source/anchors"

if [ ! -d "$ANCHOR_DIR" ] || [ -z "$(ls "$ANCHOR_DIR"/*.pem 2>/dev/null)" ]; then
    echo "No custom CA certificates found in $ANCHOR_DIR"
    exit 0
fi

import_to_profile() {
    profile="$1"
    app="$2"
    for cert in "$ANCHOR_DIR"/*.pem; do
        name=$(basename "$cert" .pem)
        certutil -A -d "sql:$profile" -n "$name" -t "CT,C,C" -i "$cert" 2>/dev/null && \
            echo "  Imported $name into $app profile $(basename "$profile")"
    done
}

for dir in ~/.mozilla/firefox/*.*/; do
    [ -f "$dir/cert9.db" ] && import_to_profile "$dir" "Firefox"
done

for dir in ~/.zen/*.*/; do
    [ -f "$dir/cert9.db" ] && import_to_profile "$dir" "Zen"
done
