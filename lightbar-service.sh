#!/bin/bash
phase=$1
pwd=$(pwd)
cd /
path=$(find /sys 2>/dev/null -name led_rgb | sed "s/led_rgb//g")
ts=$(date +"%-H:%M:%S")
pre="lightbar.service [$ts]:"

echo "$pre $phase: starting." > /dev/kmsg

#------
# Failure conditions:
# - Must have a phase to run
# - Must have the path to a lightbar with instantiated attributes
#------
if [ "$phase" = "" ]; then
	echo "$pre phase is null :(" > /dev/kmsg
	sleep 600
	exit 0
elif [ "$path" = "" ]; then
	echo "$pre no led_rgb found :(" > /dev/kmsg
	sleep 600
	exit 0
fi

#------
# Poweron phase:
# - Make the attributes writeable to non-root users
# - Switch to wake phase
#------
if [ "$phase" = "poweron" ]; then
	cd "$path"
	chmod 666 *
	cd $pwd
	echo "$pre $phase: switching phase to wake." > /dev/kmsg
	phase="wake"
fi

#------
# Sleep phase:
# - Stop the main service
# - Run the S5 sequence (which turns the lightbar off)
#------
if [ "$phase" = "sleep" ]; then

	ts=$(date +"%-H:%M:%S")
	pre="lightbar.service [$ts]:"
	echo "$pre stopping lightbar service" > /dev/kmsg

	systemctl stop lightbar.service --force

	ts=$(date +"%-H:%M:%S")
	pre="lightbar.service [$ts]:"
	echo "$pre done stopping lightbar service" > /dev/kmsg

	sleep 1

	#echo "4 0 0 0" > "$path/led_rgb"
	#sleep 1
	echo S5 > "$path/sequence"
	#sleep 1
	echo run > "$path/sequence"
fi

#------
# Wake phase:
# - Stop the main service (just in case it was already running)
# - Run the S0 sequence (which turns the lightbar on)
# - Stop subsequent sequences from being triggered
# - Do a little fade-in from black to white
# - Restart the main service, which calls this script's run phase
#------
if [ "$phase" = "wake" ]; then
	systemctl stop lightbar.service --force
	echo S0 > "$path/sequence"
	echo run > "$path/sequence"
	echo stop > "$path/sequence"
	#for i in `seq 0 5 255`; do
	#        echo "4 $i $i $i" > "$path/led_rgb"
	#	#sleep 0.15
	#done
	bash snow.sh
	systemctl restart lightbar.service --force --no-block
fi

ts=$(date +"%-H:%M:%S")
pre="lightbar.service [$ts]:"

#------
# Run phase:
# - Look for .lightbar file hanging out in the home directory
#   of logged-in user
# - Decide which whitelisted script to run
# - Bash the script, with path to lightbar as the parameter
#   Expectations:
#    - Script will echo things at lightbar attributes
#    - Script will take anywhere from a few seconds to a
#      few minutes before finishing
#       - Scripts that have static colors will switch to
#         them and sleep for a while; scripts that cycle
#         will cycle for a predetermined number of cycles
#         or minutes, etc.
#    - Service will then finish out
#    - Service will be rescheduled a second or two later
#      again checking .lightbar, so users can switch to a
#      different script and the change will take effect
#      when the current script is done
#------
if [ "$phase" = "run" ]; then

	lightbarConfigFound="0"

	#Script runs as root, so look for .lightbar in home directory
	#of logged-in user(s), starting with what is theoretically
	#the user who most recently logged-in.
	for user in $(who | tac | cut -d' ' -f1); do
		if [ "$lightbarConfigFound" = "0" ]; then
			cd /home/$user
			if [ -f ./.lightbar ]; then
				lightbarScript=$(cat ./.lightbar | sed -n 1p | cut -d' ' -f1 | cut -d'.' -f1)
				lightbarConfigFound=1
				echo "$pre .lightbar found via $user" > /dev/kmsg
			fi
		fi
	done

	if [ "$lightbarScript" = "samus" ]; then
		lightbarScript="samus.sh"
	elif [ "$lightbarScript" = "clock" ]; then
		lightbarScript="clock.sh"
	elif [ "$lightbarScript" = "blue" ]; then
		lightbarScript="blue.sh"
	elif [ "$lightbarScript" = "red" ]; then
		lightbarScript="red.sh"
	elif [ "$lightbarScript" = "redchromium" ]; then
		lightbarScript="redchromium.sh"
	elif [ "$lightbarScript" = "chromium" ]; then
		lightbarScript="chromium.sh"
	elif [ "$lightbarScript" = "cloud" ]; then
		lightbarScript="cloud.sh"
	elif [ "$lightbarScript" = "white" ]; then
		lightbarScript="white.sh"
	elif [ "$lightbarScript" = "offwhite" ]; then
		lightbarScript="offwhite.sh"
	elif [ "$lightbarScript" = "sky" ]; then
		lightbarScript="sky.sh"
	elif [ "$lightbarScript" = "green" ]; then
		lightbarScript="green.sh"
	elif [ "$lightbarScript" = "random" ]; then
		lightbarScript="random-throb.sh"
	else
		lightbarScript="whiteshort.sh"
	fi

	echo "$pre bashing $lightbarScript" > /dev/kmsg

	bash "/usr/local/bin/$lightbarScript" "$path"

	echo "$pre done bashing $lightbarScript" > /dev/kmsg
fi

ts=$(date +"%-H:%M:%S")
pre="lightbar.service [$ts]:"
echo "$pre $phase: done." > /dev/kmsg
