#!/bin/sh

# i3
if i3-msg restart; then
    notify-send 'i3 restarted'
else
    notify-send -u critical "i3 COUDN'T BE restarted"
fi

export network=`echo $(ip route | grep '^default' | awk '{print $5}' | head -n1)`
export temperature=`for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $i"; done | tail -2 | head -1 | cut -d " " -f 4`
# polybar
if killall polybar; sleep 1 && polybar -q main -c ~/.config/polybar/config.ini; then
    notify-send 'polybar restarted'
else
    notify-send -u critical "polybar COUDN'T BE restarted"
fi

# lib input
if libinput-gestures-setup restart; then
    notify-send 'libinput-gestures restarted'
else
    notify-send -u critical "libinput-gestures COUDN'T BE restarted"
fi
