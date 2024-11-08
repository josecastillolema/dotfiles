#! /bin/bash

BAT=$(echo /sys/class/power_supply/BAT*)
BAT_STATUS="$BAT/status"
BAT_CAP="$BAT/capacity"
LOW_BAT_PERCENT=25

#AC_PROFILE="performance"
AC_PROFILE="throughput-performance"
BAT_PROFILE="balanced"
#LOW_BAT_PROFILE="power-saver"
LOW_BAT_PROFILE="powersave"

#DRIVER="powerprfilesctl set"
DRIVER="tuned-adm profile"

# wait a while if needed
[[ -z $STARTUP_WAIT ]] || sleep "$STARTUP_WAIT"

# start the monitor loop
prev=0

while true; do
	# read the current state
	if [[ $(cat "$BAT_STATUS") == "Discharging" ]]; then
		if [[ $(cat "$BAT_CAP") -gt $LOW_BAT_PERCENT ]]; then
			profile=$BAT_PROFILE
		else
			profile=$LOW_BAT_PROFILE
		fi
	else
		profile=$AC_PROFILE
	fi

	# set the new profile
	if [[ $prev != "$profile" ]]; then
		echo setting power profile to $profile
		$DRIVER $profile
	fi

	prev=$profile

	# wait for the next power change event
	inotifywait -qq "$BAT_STATUS" "$BAT_CAP"
done
