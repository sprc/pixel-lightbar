#!/bin/bash
night=$(bash colorwheel.sh night)
dawn=$(bash colorwheel.sh dawn)
sr=$(bash colorwheel.sh sunrise)
morn=$(bash colorwheel.sh morning)
an=$(bash colorwheel.sh afternoon)
ss=$(bash colorwheel.sh sunset)

for i in `seq 1 1 10`; do
	bash colorshift.sh "$night" "$dawn"
	sleep 15
	bash colorshift.sh "$dawn" "$sr"
	sleep 15
	bash colorshift.sh "$sr" "$morn"
	sleep 15
	bash colorshift.sh "$morn" "$an"
	sleep 15
	bash colorshift.sh "$an" "$ss"
	sleep 15
	bash colorshift.sh "$ss" "$night"
done
