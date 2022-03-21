#!/bin/sh

export network=`echo $(ip route | grep '^default' | awk '{print $5}' | head -n1)`
export temperature=`for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $i"; done | tail -2 | head -1 | cut -d " " -f 4`

# set screen setup
xrandr | grep -i "Disconnected" | cut -d " " -f1 | xargs -I{} xrandr --output {} --off
xrandr | grep -i " connected" | cut -d " " -f1 | xargs -I{} xrandr --output {} --auto
if [ $(xrandr | grep " connected" | wc -l) -gt 1 ]; then
	# xrandr --output DP-0 --auto && 
	xrandr --output "DP-0" --auto --above "DP-2"
	#xrandr --output DP-0 --pos 0x0 --rotate left --output DP-2 --pos 1080x560
fi

# kill notification daemon
killall -q dunst

sleep 1
# polybar
/home/simon/.config/polybar/launch.sh

# i3
if i3-msg restart; then
    notify-send 'i3 restarted'
else
    notify-send -u critical "i3 COUDN'T BE restarted"
fi

# lib input
if libinput-gestures-setup restart; then
    notify-send 'libinput-gestures restarted'
else
    notify-send -u critical "libinput-gestures COUDN'T BE restarted"
fi

feh --randomize --bg-fill ~/Wallpapers/*
