#!/bin/sh

export network=`echo $(ip route | grep '^default' | awk '{print $5}' | head -n1)`
export temperature=`for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $i"; done | tail -2 | head -1 | cut -d " " -f 4`

# set screen setup
xrandr | grep -i "Disconnected" | cut -d " " -f1 | xargs -I{} xrandr --output {} --off
xrandr | grep -i " connected" | cut -d " " -f1 | xargs -I{} xrandr --output {} --auto
if [ $(xrandr | grep " connected" | wc -l) -gt 1 ]; then
	xrandr --output DP-0 --auto && xrandr --output "DP-2" --auto --output "DP-0" --left-of "DP-2"
	#xrandr --output DP-0 --pos 0x0 --rotate left --output DP-2 --pos 1080x560
	notify-send "External monitor detected!"
else
	notify-send "No external monitor detected!"
fi

# kill notification daemon
killall -q dunst

sleep 1
# polybar
if killall polybar; sleep 1 && polybar -q asus -c ~/.config/polybar/config.ini; sleep .5 && polybar -q main -c ~/.config/polybar/config.ini || [ "$1" = "--exit" ]; then
		# exit if parameter is set
		if [ "$1" = "--exit" ]; then
			exit
		fi
    notify-send 'polybar restarted'
else
    notify-send -u critical "polybar COUDN'T BE restarted"
fi

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
