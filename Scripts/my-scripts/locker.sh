#! /bin/bash

# get window windowName
windowName=$(xdotool getactivewindow getwindowname | grep -civ "youtube")

# if $windowName -eq 1
if [ $windowName -ge 1 ]
then
	# lock
	i3lock-fancy
fi
