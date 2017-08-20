#!/bin/bash

path=$1

if [ "$path" = "" ]; then
        echo "No path :(" > /dev/kmsg
        exit 0
fi

if [ " $2" = " " ]; then
	speed=0.1
else
	speed=$2
fi

if [ " $3" = " " ]; then
	minR=50
	maxR=200
else
	minR=$(echo $3 | cut -d\- -f1)
	maxR=$(echo $3 | cut -d\- -f2)
fi

if [ " $4" = " " ]; then
        minG=75
        maxG=200
else
        minG=$(echo $4 | cut -d\- -f1)
        maxG=$(echo $4 | cut -d\- -f2)
fi

if [ " $5" = " " ]; then
        minB=100
        maxB=255
else
        minB=$(echo $5 | cut -d\- -f1)
        maxB=$(echo $5 | cut -d\- -f2)
fi

R=$(rand.sh $minR $maxR)
G=$(rand.sh $minG $maxG)
B=$(rand.sh $minB $maxB)

while true
do
	echo stop > "$path/sequence"

	newR=$(rand.sh $minR $maxR)
	newG=$(rand.sh $minG $maxG)
	newB=$(rand.sh $minB $maxB)

	if [ $R -lt $newR ]; then
		rStep=$(rand.sh 1 10)
	else
		rStep=-$(rand.sh 1 10)
	fi

        if [ $G -lt $newG ]; then
                gStep=$(rand.sh 1 10)
        else
                gStep=-$(rand.sh 1 10)
        fi

        if [ $B -lt $newB ]; then
                bStep=$(rand.sh 1 10)
        else
                bStep=-$(rand.sh 1 10)
        fi

	for color in `seq $R $rStep $newR`
	do
		echo "0 $color $G $B  1 $color $G $B  2 $color $G $B  3 $color $G $B" > "$path/led_rgb"
		sleep $speed
	done

	R=$color

        for color in `seq $G $gStep $newG`
        do
		echo "0 $R $color $B  1 $R $color $B  2 $R $color $B  3 $R $color $B" > "$path/led_rgb"
                sleep $speed
        done

        G=$color

        for color in `seq $B $bStep $newB`
        do
                echo "0 $R $G $color  1 $R $G $color  2 $R $G $color  3 $R $G $color" > "$path/led_rgb"
                sleep $speed
        done

        B=$color

done
