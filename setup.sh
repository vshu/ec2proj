#!/bin/bash
echo "Bootcamp DevOps" >> /etc/motd.tail;
echo "export BCDO=BootcampDevOps" > /etc/profile.d/bcdo.sh;
sudo apt-get update 2>&1 1>/dev/null;
sudo apt-get install -y language-pack-en 2>&1 1>/dev/null;
sudo locale-gen en_US 2>&1 1>/dev/null;
sudo apt-get install -y puppetmaster puppet 2>&1 1>/dev/null;
sudo apt-get install -y jenkins 2>&1 1>/dev/null;
sudo apt-get install -y python-pip 2>&1 1>/dev/null;
