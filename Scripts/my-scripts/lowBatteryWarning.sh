#!/bin/bash
# https://bbs.archlinux.org/viewtopic.php?pid=1080737#p1080737

BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:30:00 ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send "Low battery" "$BATTINFO"
fi
