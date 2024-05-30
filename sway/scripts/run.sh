if ! pgrep $3 >/dev/null; then
  $1
elif [[ $(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name' | tr -cd '[:digit:]\n') == "$2" ]]; then
  $1
else
  swaymsg workspace $2
fi
