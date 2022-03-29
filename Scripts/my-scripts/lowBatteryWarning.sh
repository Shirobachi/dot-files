#!/bin/bash
# https://bbs.archlinux.org/viewtopic.php?pid=1080737#p1080737

BATTINFO=$(acpi -b)
if echo "$BATTINFO" | grep -q "Discharging"; then
	if [[ $(echo "$BATTINFO" | cut -f 5 -d " ") < 00:05:00 ]]; then
		notify-send -u critical "Battery empty, shutting down" "Your layout will be attempted to save"; $HOME/Scripts/my-scripts/sessionManager.sh -s; systemctl poweroff
	elif [[ $(echo "$BATTINFO" | cut -f 5 -d " ") < 00:30:00 ]]; then
			DISPLAY=:0.0 /usr/bin/notify-send "Low battery" "$BATTINFO"
    fi
fi
