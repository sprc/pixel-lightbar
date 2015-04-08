#!/bin/bash

count=3
speed=0.1
path=$(sh init.sh)

for i in `seq 1 $count`
do
	echo "0 0 0 255  1 0 0 255  2 255 255 0  3 0 0 255" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 255  1 0 0 255  2 255 255 0  3 175 175 255" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 255  1 0 0 255  2 255 255 0  3 255 255 255" > "$path/led_rgb"
	sleep $speed
	echo "0 100 100 150  1 100 100 150  2 255 255 125  3 175 175 255" > "$path/led_rgb"
	sleep $speed
	echo "0 125 125 100  1 125 125 100  2 200 200 150  3 125 125 100" > "$path/led_rgb"
	sleep $speed
	sleep $speed
	echo "0 100 100 150  1 175 175 255  2 255 255 125  3 100 100 150" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 255  1 255 255 255  2 255 255 0  3 0 0 255"  > "$path/led_rgb"
	sleep $speed
	echo "0 175 175 255  1 175 175 255  2 255 255 0  3 0 0 255" > "$path/led_rgb"
	sleep $speed
	echo "0 255 255 255  1 0 0 255  2 255 255 0  3 0 0 255" > "$path/led_rgb"
	sleep $speed
	echo "0 175 175 255  1 0 0 255  2 255 255 0  3 0 0 255" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 255  1 0 0 255  2 255 255 0  3 0 0 255" > "$path/led_rgb"
	sleep $speed
done
sh reset-lightbar.sh $path
