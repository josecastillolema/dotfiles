ORIGINAL=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true).id')
swaymsg '[app_id="thunar"] focus'

# Apparently wtype does not work with Thunar :(
wtype -k Down

# ydotool does not seem to work either (plus very complicated, daemon, sudo access, etc.)
#ydotool key 108:1 108:0

swaymsg "[con_id=$ORIGINAL] focus"
