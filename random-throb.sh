#!/bin/bash

if [ " $1" = " " ]; then
	count=2500
else
	count=$1
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

path=$(sh init.sh)

R=$(sh rand.sh $minR $maxR)
G=$(sh rand.sh $minG $maxG)
B=$(sh rand.sh $minB $maxB)

for i in `seq 1 $count`
do
	sh cycle.sh $path

	newR=$(sh rand.sh $minR $maxR)
	newG=$(sh rand.sh $minG $maxG)
	newB=$(sh rand.sh $minB $maxB)

	if [ $R -lt $newR ]; then
		rStep=$(sh rand.sh 1 10)
	else
		rStep=-$(sh rand.sh 1 10)
	fi

	#if [ $newG -lt $newB ]; then
	#	if [ $newG -lt $newR ]; then
	#		if [ $newB -lt $newR ]; then
	#			newG=$newR
	#		else
	#			newG=$newB
	#		fi
	#	fi
	#fi

        if [ $G -lt $newG ]; then
                gStep=$(sh rand.sh 1 10)
        else
                gStep=-$(sh rand.sh 1 10)
        fi

        #if [ $newB -lt $newR ]; then
        #        temp=$newB
        #        newB=$newR
	#	newR=$temp
        #fi

        if [ $B -lt $newB ]; then
                bStep=$(sh rand.sh 1 10)
        else
                bStep=-$(sh rand.sh 1 10)
        fi

	echo R $R $newR
	echo G $G $newG
	echo B $B $newB

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
sh reset-lightbar.sh $path
