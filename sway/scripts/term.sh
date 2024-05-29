if [[ "$(pgrep wezterm > /dev/null; echo $?)" != 0 ]]; then
  echo case1 >> /tmp/test
  flatpak run org.wezfurlong.wezterm
elif [[ $(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name' | tr -cd '[:digit:]\n') == "3" ]]; then
  echo case2 >> /tmp/test
  swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name' >> /tmp/test
  flatpak run org.wezfurlong.wezterm
else
  echo case3 >> /tmp/test
  swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name' >> /tmp/test
  swaymsg workspace 3
fi
