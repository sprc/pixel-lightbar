#!/bin/bash

#-----
# Array subscripts / looping values
#-----
fromTo="f t"
leds="0 1 2 3"
colors="r g b"

#-----
# 3D arrays require you to declare them as associative arrays
#-----
declare -A rgb
declare -A values

#-----
# Param 1 = "From" colors, param 2 = "To" colors
#-----
values[f]=$1
values[t]=$2

#-----
# If either params are blank, substitute 4 0 0 0 (black)
#-----
for ft in $fromTo; do
	if [ "${values[$ft]}" = "" ]; then
		values[$ft]="4 0 0 0"
	fi
done

#-----
# Count the pieces in each parameter
#-----
pieces[f]=$(echo ${values[f]} | awk -F" " "{ print NF }")
pieces[t]=$(echo ${values[t]} | awk -F" " "{ print NF }")

#-----
# Store values in rgb array
#-----
for ft in $fromTo; do
	for i in `seq 1 ${pieces[$ft]}`; do		
		pc=$(echo "${values[$ft]}" | cut -d' ' -f$i)
		echo $ft $i $pc
		if [ "$led" = "" ]; then
			led="$pc"
		elif [ "${rgb[$ft,$led,r]}" = "" ]; then
			rgb[$ft,$led,r]="$pc"
		elif [ "${rgb[$ft,$led,g]}" = "" ]; then
			rgb[$ft,$led,g]="$pc"
		elif [ "${rgb[$ft,$led,b]}" = "" ]; then
			rgb[$ft,$led,b]="$pc"
			led=""
		fi
	done
done

#-----
# Check to see if led '4' was passed in; this is shorthand for
# 'set all 4 leds to the same color'.
#-----
for ft in $fromTo; do
	if [ "${rgb[$ft,4,r]}" != "" ]; then
		for l in $leds; do
			for c in $colors; do
				rgb[$ft,$l,$c]="${rgb[$ft,4,$c]}"
			done
		done
	fi
done

#-----
# Check for nulls. If found, substitute 0s.
#-----
for ft in $fromTo; do
	for l in $leds; do
		for c in $colors; do
			if [ "${rgb[$ft,$l,$c]}" = "" ]; then
				rgb[$ft,$l,$c]=0
			fi
		done
	done
done

#-----
# Calculate the maximum difference between any two given
# colors. This ultimately determines how many iterations
# we'll have to do to get from one color to the next.
# For the other colors that don't have as far to go, we
# will have to figure out a modified speed to move at.
# 
# For example, take $led 0 20 40 and $led 15 60 60.
# The maximum movement will be green at 40, so you'll
# need to move blue 0.5 steps (20/40) for every 1 step
# green takes. Similarly, you'd move red 0.375 steps
# for every green step.
#-----
diff=0
maxDiff=0
for l in $leds; do
	for c in $colors; do
		((diff=${rgb[f,$l,$c]}-${rgb[t,$l,$c]}))
		if [ $diff -lt 0 ]; then
			((diff=-1*diff))
		fi
		if [ $diff -gt $maxDiff ]; then
			maxDiff=$diff
		fi
	done
done	

echo $maxDiff
