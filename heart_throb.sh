#!/bin/bash

count=25
min=75
step=5
max=255
speed=0.1
path=$(sh init.sh)

for i in `seq 1 $count`
do
	for color in `seq $min $step $max`
	do
		echo "0 $color 0 0  1 $color 0 0  2 $color 0 0  3 $color 0 0" > "$path/led_rgb"
		sleep $speed
	done

	sleep $speed
	sleep $speed
	sleep $speed
	sleep $speed
	sleep $speed

	for color in `seq $max -$step $min`
	do
		echo "0 $color 0 0  1 $color 0 0  2 $color 0 0  3 $color 0 0" > "$path/led_rgb"
		sleep $speed
	done

	sleep $speed
	sleep $speed
	sleep $speed
	sleep $speed
	sleep $speed
done
sh reset-lightbar.sh $path
