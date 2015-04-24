#!/bin/bash

count=2500
speed=0.1
path=$(sh init.sh)

R=$(sh rand255.sh)
G=$(sh rand255.sh)
B=$(sh rand255.sh)

for i in `seq 1 $count`
do
	sh cycle.sh $path

	newR=$(sh rand255.sh)
	newG=$(sh rand255.sh)
	newB=$(sh rand255.sh)

	if [ $R -lt $newR ]; then
		rStep=5
		echo Red: $R $newR
	else
		rStep=-5
		echo Red: $R $newR
	fi

        if [ $G -lt $newG ]; then
                gStep=5
                echo Green: $G $newG
        else
                gStep=-5
                echo Green: $G $newG
        fi

	if [ $newG -lt $newB ]; then
		if [ $newG -lt $newR ]; then
			if [ $newB -lt $newR ]; then
				newG=$newR
			else
				newG=$newB
			fi
		fi
	fi

        if [ $B -lt $newB ]; then
                bStep=5
                echo Blue: $B $newB
        else
                bStep=-5
                echo Blue: $B $newB
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

	sleep $speed
	sleep $speed
	sleep $speed
	sleep $speed
	sleep $speed
done
sh reset-lightbar.sh $path
