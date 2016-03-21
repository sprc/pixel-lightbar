#!/bin/bash
sudo systemctl stop lightbar.service
sudo systemctl stop lightbarwake.service
sudo cp binary-lightbar.sh /usr/local/bin/
sudo cp clock.sh /usr/local/bin/
sudo cp lightbar-service.sh /usr/local/bin/
sudo cp *.service /etc/systemd/system/
cd /etc/systemd/system
sudo systemctl disable lightbarsleep.service lightbarwake.service lightbarpoweron.service lightbar.service
sudo systemctl enable lightbarsleep.service lightbarwake.service lightbarpoweron.service lightbar.service
sudo systemctl start lightbarwake.service &
echo "Done"
