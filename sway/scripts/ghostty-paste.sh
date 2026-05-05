#!/bin/sh
# Until: https://github.com/ghostty-org/ghostty/discussions/12181
# Workaround: Ghostty GTK4 does not handle middle-click paste from primary selection.
# This script listens for Sway focus changes and dynamically binds/unbinds
# middle-click -> Shift+Insert only when Ghostty is focused.

swaymsg -t subscribe -m '["window"]' | while read -r event; do
    app_id=$(echo "$event" | jq -r '.container.app_id // empty')
    change=$(echo "$event" | jq -r '.change')
    if [ "$change" = "focus" ]; then
        if [ "$app_id" = "com.mitchellh.ghostty" ]; then
            swaymsg 'bindsym --whole-window button2 exec wtype -M shift -k Insert'
        else
            swaymsg 'unbindsym --whole-window button2'
        fi
    fi
done
