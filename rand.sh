#!/bin/sh

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
