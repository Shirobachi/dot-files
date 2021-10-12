#!/bin/bash

# hide notifications
killall dunst

flameshot full -c
window=$(xdotool getactivewindow getwindowname | grep -ci "teams\|skype")

# if $windows is 1, then the window is teams
if [ $window -eq 1 ]; then
	# Go to 1 workspace
	i3-msg workspace 9 &&

	# symulate ctrl + v after delay
	sleep 0.5 &&
	xdotool getactivewindow key ctrl+v && 

	# confirm return
	xdotool key Return &&

	# Go previous workspace
	i3-msg workspace back_and_forth || notify-send "Error" "Error occupied!"
fi
