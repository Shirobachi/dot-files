#!/bin/bash

# hide notifications
killall dunst

window=$(xdotool getactivewindow getwindowname | grep -ci "teams\|skype")

# if $windows is 1, then the window is teams
if [ $window -eq 1 ]; then

	flameshot full -c

	# Go to 1 workspace
	i3-msg workspace 9 &&
	sleep 0.5 &&

	# symulate ctrl + v after delay
	xdotool getactivewindow key ctrl+v && 

	xdotool key Return &&
	sleep 0.5 &&

	# confirm return
	xdotool key Return &&
	sleep 0.5 &&

	# Go previous workspace
	i3-msg workspace back_and_forth || notify-send "Error" "Error occupied!"
else
	flameshot full -c
fi

