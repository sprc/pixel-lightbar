#!/bin/sh

expression=$1
place=$2

if [ " " = " $place" ] ; then
	place=2
fi

echo $expression
echo $place

echo $(printf "%."$place"f" $(echo "scale=$(echo ""$place + 1"" | bc);$expression" | bc))
