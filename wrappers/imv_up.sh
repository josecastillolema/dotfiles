ORIGINAL=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true).id')
swaymsg '[app_id="thunar"] focus'

# Apparently wtype does not work with Thunar :(
# TODO: Test with ydotool
wtype -k Up

swaymsg "[con_id=$ORIGINAL] focus"
