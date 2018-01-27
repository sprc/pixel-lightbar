#!/bin/bash
sudo systemctl stop lightbar.service
sudo systemctl stop lightbarwake.service
sudo cp binary-lightbar.sh /usr/local/bin/
sudo cp samus.sh /usr/local/bin/
sudo cp clock.sh /usr/local/bin/
sudo cp blue.sh /usr/local/bin/
sudo cp red.sh /usr/local/bin/
sudo cp redchromium.sh /usr/local/bin/
sudo cp chromium.sh /usr/local/bin/
sudo cp cloud.sh /usr/local/bin/
sudo cp offwhite.sh /usr/local/bin/
sudo cp white.sh /usr/local/bin/
sudo cp whiteshort.sh /usr/local/bin/
sudo cp sky.sh /usr/local/bin/
sudo cp green.sh /usr/local/bin/
sudo cp snow.sh /usr/local/bin/
sudo cp colorshift.sh /usr/local/bin/
sudo cp random-throb.sh /usr/local/bin/
sudo cp colorwheel.sh /usr/local/bin/
sudo cp lightbar-service.sh /usr/local/bin/
sudo cp init.sh /usr/local/bin/
sudo cp rand.sh /usr/local/bin/
sudo cp *.service /etc/systemd/system/
cd /etc/systemd/system
sudo systemctl disable lightbarsleep.service lightbarwake.service lightbarpoweron.service lightbar.service
sudo systemctl enable lightbarsleep.service lightbarwake.service lightbarpoweron.service lightbar.service
sudo systemctl start lightbarwake.service &
echo "Done"
