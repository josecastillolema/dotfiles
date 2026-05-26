#!/bin/sh

# Workaround for systemd 259 not applying HandleLidSwitchExternalPower=ignore
swaymsg output eDP-1 disable

if [ "$(cat /sys/class/power_supply/AC/online)" = "0" ]; then
  systemctl suspend
fi
