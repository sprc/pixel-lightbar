#!/bin/bash
night=$(bash colorwheel.sh night)
dawn=$(bash colorwheel.sh dawn)
sr=$(bash colorwheel.sh sunrise)
morn=$(bash colorwheel.sh morning)
an=$(bash colorwheel.sh afternoon)
ss=$(bash colorwheel.sh sunset)


bash colorshift.sh "$night" "$dawn"
sleep 10
bash colorshift.sh "$dawn" "$sr"
sleep 10
bash colorshift.sh "$sr" "$morn"
sleep 10
bash colorshift.sh "$morn" "$an"
sleep 10
bash colorshift.sh "$an" "$ss"
sleep 10
bash colorshift.sh "$ss" "$night"
