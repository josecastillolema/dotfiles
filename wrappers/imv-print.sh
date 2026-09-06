#!/bin/sh
if [ "$1" = "--dialog" ]; then
  exec flock -n ~/tmp/.imv-print.lock sh -c '
    file=$(cat ~/tmp/.imv-print-file)
    printer=$(lpstat -a | cut -d" " -f1 | rofi -dmenu -p "Print to:") && lp -d "$printer" "$file"
  '
else
  echo "$1" > ~/tmp/.imv-print-file
  swaymsg exec "$HOME/dev/dotfiles/wrappers/imv-print.sh --dialog"
fi
