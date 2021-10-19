#!/bin/bash

# hide notifications
killall dunst

window=$(xdotool getactivewindow getwindowname | grep -ci "teams\|skype")

# if $windows is 1, then the window is teams
if [ $window -eq 1 ]; then

	xdotool mousemove 0 0
	xdotool click 1
	sleep .4
	flameshot full -c

	# Go to 1 workspace
	i3-msg workspace 9 &&

	# symulate ctrl + v after delay
	sleep 0.5 &&
	xdotool getactivewindow key ctrl+v && 

	# confirm return
	xdotool key Return &&

	# Go previous workspace
	i3-msg workspace back_and_forth || notify-send "Error" "Error occupied!"
else
	flameshot full -c
fi
