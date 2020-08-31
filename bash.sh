#!/bin/bash

sudo apt update
sudo apt install -y wireless-tools
sudo apt install -y iw
sudo iw reg set NL
sudo systemctl mask wpa_supplicant.service
sudo mv /sbin/wpa_supplicant /sbin/no_wpa_supplicant
sudo pkill wpa_supplicant

ifconfig wlan0 192.168.254.1/24 up
sudo docker run -d -t \
  -e INTERFACE=wlan0 \
  -e CHANNEL=6 \
  -e SSID=IOT \
  -e AP_ADDR=192.168.254.1 \
  -e SUBNET=192.168.254.0 \
  -e WPA_PASSPHRASE=adminIOT \
  -e OUTGOINGS=eth0 \
  --privileged \
  --net host \
  sdelrio/rpi-hostap:latest
