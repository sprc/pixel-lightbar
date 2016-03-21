#!/bin/bash
phase=$1
cd /
path=$(find /sys 2>/dev/null -name led_rgb | sed "s/led_rgb//g")
ts=$(date +"%-H:%M:%S")
pre="lightbar.service [$ts]:"
pwd=$(pwd)

echo "$pre $phase: starting." > /dev/kmsg

if [ "$phase" = "" ]; then
	echo "$pre phase is null :(" > /dev/kmsg
	exit 0
elif [ "$path" = "" ]; then
	echo "$pre no led_rgb found :(" > /dev/kmsg
	exit 0
fi

if [ "$phase" = "poweron" ]; then
	cd "$path"
	chmod 666 *
	cd $pwd
	echo "$pre $phase: switching phase to wake." > /dev/kmsg
	phase="wake"
fi

if [ "$phase" = "sleep" ]; then
	sudo systemctl stop lightbar.service --force
        echo S5 > "$path/sequence"
        echo run > "$path/sequence"
fi

if [ "$phase" = "wake" ]; then
	sudo systemctl stop lightbar.service --force
	echo S0 > "$path/sequence"
	echo run > "$path/sequence"
	echo stop > "$path/sequence"
	for i in `seq 25 5 250`; do
	        echo "4 $i $i $i" > "$path/led_rgb"
		sleep 0.05
	done
	sudo systemctl restart lightbar.service --force --no-block
fi

if [ "$phase" = "run" ]; then
	bash /usr/local/bin/clock.sh "$path"
fi

ts=$(date +"%-H:%M:%S")
pre="lightbar.service [$ts]:"

echo "$pre $phase: done." > /dev/kmsg
