#!/bin/bash

count=3
speed=0.1
path=$(sh init.sh)

for i in `seq 1 $count`
do
	echo "0 255 0 0  1 0 0 0  2 0 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 255 0 0  2 0 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 0 0 0  2 255 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 0 0 0  2 0 0 0  3 255 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 0 0 0  2 255 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 255 0 0  2 0 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 125 0 0  1 0 0 0  2 0 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 125 0 0  2 0 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 0 0 0  2 125 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 0 0 0  2 0 0 0  3 125 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 0 0 0  2 125 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
	echo "0 0 0 0  1 125 0 0  2 0 0 0  3 0 0 0" > "$path/led_rgb"
	sleep $speed
done
sh reset-lightbar.sh $path
