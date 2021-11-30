#!/bin/bash

# hide notifications
killall dunst

window=$(xdotool getactivewindow getwindowname | grep -ci "teams\|skype")

# if $windows is 1, then the window is teams
if [ $window -eq 1 ]; then

	flameshot full -c

	# Go to 1 workspace
	i3-msg workspace 9 &&

	# symulate ctrl + v after delay
	sleep 0.5 &&
	
	xdotool getactivewindow key super+v && 
	sleep 0.5 &&
	xdotool key Return &&
	sleep 0.5 &&

	# confirm return
	xdotool key Return &&

	# Go previous workspace
	i3-msg workspace back_and_forth || notify-send "Error" "Error occupied!"
else
	flameshot full -c
fi
