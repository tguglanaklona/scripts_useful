#!bin/bash
echo "eth0:"
ifconfig eth0 down
macchanger -a eth0
ifconfig eth0 up
echo "wlan0:"
ifconfig wlan0 down
macchanger -a wlan0
ifconfig wlan0 up
/etc/init.d/networking restart