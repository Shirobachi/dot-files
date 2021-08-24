#!/bin/bash

# make an array with options
sure=( "Sure" "Are you sure" "RU sure" "Do it" "We do it" "Really" )
yes=( "Yes" "Yeah" "HELLL YEAH" "OH YEAH" "OFC BABy" "non't" )
no=( "No" "Nope" "Nah" "Naw" "Nawww" "Nawwwww" )

# make randomized options
randomChoice=$((RANDOM%6))
yes=${yes[$randomChoice]}
no=${no[$randomChoice]}
sure=${sure[$randomChoice]}

if [ "$1" == "restart" ] && [ "`echo -e \"$yes\n$no\" | rofi -dmenu -p \"$sure\" -width 10 -lines 2`" == "$yes" ]; then
	notify-send "Restarting..."
	killall chrome
	sleep 1 && systemctl reboot
elif [ "$1" == "shutdown" ] && [ "`echo -e \"$yes\n$no\" | rofi -dmenu -p \"$sure\" -width 10 -lines 2`" == "$yes" ]; then
	notify-send "Shutdowning..."
	killall chrome
	sleep 1 && systemctl poweroff
elif [ "$1" == "logout" ] && [ "`echo -e \"$yes\n$no\" | rofi -dmenu -p \"$sure\" -width 10 -lines 2`" == "$yes" ]; then
	notify-send "Logout..."
	killall chrome
	sleep 1 && i3-msg exit
elif [ "$1" == "lock" ]; then
	i3lock-fancy -p
fi