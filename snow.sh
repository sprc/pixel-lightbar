#!/bin/bash


#path=$1
path=$(find /sys 2>/dev/null -name led_rgb | sed "s/led_rgb//g")

function rand()
{
if [ " $2" = " " ]; then
	scale=$1
else
	min=$1
	scale=$(($2-$1+1))
fi

if [ " $scale" = " " ]; then
	scale=255
fi

if [ " $min" = " " ]; then
	min=0
fi

echo $(od -An -N8 -t u8 /dev/urandom)%$scale+$min | bc
}

for i in `seq 1 3 255`; do
	led0=$(rand 1 $i)
	led1=$(rand 1 $i)
	led2=$(rand 1 $i)
	led3=$(rand 1 $i)
	sleep .05
	echo "0 $led0 $led0 $led0 1 $led1 $led1 $led1 2 $led2 $led2 $led2 3 $led3 $led3 $led3" > "$path/led_rgb"
done

for i in `seq 1 3 255`; do
        led0=$(rand $i 255)
        led1=$(rand $i 255)
        led2=$(rand $i 255)
        led3=$(rand $i 255)
	sleep .05
        echo "0 $led0 $led0 $led0 1 $led1 $led1 $led1 2 $led2 $led2 $led2 3 $led3 $led3 $led3" > "$path/led_rgb"
done

echo "4 255 255 255" > "$path/led_rgb"

sleep 2

for i in `seq 255 -5 0`; do
        echo "4 $i $i $i" > "$path/led_rgb"
done
