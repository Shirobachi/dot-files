#!/bin/sh

# i3
if i3-msg restart; then
    notify-send 'i3 restarted'
else
    notify-send "i3 COUDN'T BE restarted"
fi

# polybar
if killall polybar; polybar -q main -c ~/.config/polybar/config.ini; then
    notify-send 'polybar restarted'
else
    notify-send "polybar COUDN'T BE restarted"
fi

# lib input
if libinput-gestures-setup restart; then
    notify-send 'libinput-gestures restarted'
else
    notify-send "libinput-gestures COUDN'T BE restarted"
fi
