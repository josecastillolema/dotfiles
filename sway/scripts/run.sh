ws_has_app=$(swaymsg -t get_tree | jq --arg ws "$2" --arg app "$3" '
  [.nodes[].nodes[] | select(.name == $ws) |
   .nodes[]?, .floating_nodes[]? | recurse(.nodes[]?, .floating_nodes[]?) |
   select(.type == "con" and ((.app_id // .window_properties.class // "") | test($app; "i")))] | length > 0')

if [[ "$ws_has_app" != "true" ]]; then
  $1
elif [[ $(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .name' | tr -cd '[:digit:]\n') == "$2" ]]; then
  $1
else
  swaymsg workspace $2
fi
