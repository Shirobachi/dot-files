#! /bin/bash

# get window windowName
windowName=$(xdotool getactivewindow getwindowname | grep -cive "youtube\|teams")

# if $windowName -eq 1
if [ "$windowName" -ge 1 ]
then
	# lock
	i3lock-fancy
fi
