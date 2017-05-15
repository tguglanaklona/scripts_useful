#!bin/sh
### BEGIN INIT INFO
# Provides:          changemac2
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# X-Interactive:     true
# Short-Description: changemac2 script (macchanger)
### END INIT INFO
rm -r /etc/NetworkManager/system-connections/*
echo "eth0:"
ifconfig eth0 down
macchanger -a eth0
ifconfig eth0 up
echo "wlan0:"
ifconfig wlan0 down
macchanger -a wlan0
ifconfig wlan0 up
/etc/init.d/networking restart
