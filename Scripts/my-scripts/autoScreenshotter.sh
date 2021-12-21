#!/bin/bash

function updateLastScreenshot(){
	# delete /tmp/$SCRIPT_NAME.png if exists
	if [ -f /tmp/$SCRIPT_NAME.png ]; then
		rm /tmp/$SCRIPT_NAME.png
	fi

	# copy file to /tmp/$SCRIPT_NAME.png
	cp "$ssFilename" "/tmp/$SCRIPT_NAME.png"
}

# function send to discord
function sendToDiscord(){
	updateLastScreenshot

	# change workspace to 9
	i3-msg workspace 9 > /dev/null

	# wait for 0.5 sec
	sleep 0.5

	# xdotool key paste
	xdotool key ctrl+v

	# wait for 0.5 sec
	sleep 0.5

	# xdotool key Return
	xdotool key Return

	# wait for 0.5 sec
	sleep 0.5

	# Go back to previous workspace
	i3-msg workspace back_and_forth > /dev/null
}

# --------------------------------------------------

# set -x if flag is set
if [ "$1" = "-x" ]; then
	set -x
fi
export DISPLAY=:0.0

# get script filename without extension
SCRIPT_NAME=$(basename "$0" | cut -d. -f1)

# check if PID file exists
if [ -f /tmp/"$SCRIPT_NAME".pid ]; then
	echo "PID file exists"
	exit 1
else
	# save PID 
	echo $$ > /tmp/"$SCRIPT_NAME".pid
fi

# remove PID and /tmp $SCRIPT_NAME.png on exit
trap 'rm -f /tmp/$SCRIPT_NAME.pid /tmp/$SCRIPT_NAME.png' EXIT

# make fullscreen screenshot via flameshot
## make variable with current date
date=$(date +%Y-%m-%d_%H-%M-%S)

## make dir $HOME/Downloads/$date if not exists
if [ ! -d "$HOME/Downloads/$date" ]; then
	mkdir -p "$HOME/Downloads/$date/log"
fi

while true; do 

	killall dunst > /dev/null 2>&1

	## Finaly make ss
	flameshot full -p "$HOME/Downloads/$date/" -c
	sleep .5

	# find the latest screenshot
	ssFilename=$(find "$HOME/Downloads/$date" -type f -printf "%T@ %p\n" | sort -n | cut -d' ' -f2- | tail -1)

	# Check if file /tmp/$SCRIPT_NAME.png not exists
	if [ ! -f "/tmp/$SCRIPT_NAME.png" ]; then
		# run sendToDiscord
		sendToDiscord
	else
		# check if not `which magick`
		if [ ! $(which magick) ]; then
			# Get place to save magick
			path=$(echo "$PATH" | tr ":" "\n" | head -1)
			
			# Download macick from url
			link="https://download.imagemagick.org/ImageMagick/download/binaries/magick"
			wget "$link" -O "$path"/magick
			chmod +x "$path"/magick
		fi

		filename=$(echo $ssFilename | cut -d"/" -f6)
		diff=$(magick compare -metric RMSE -subimage-search "$ssFilename" "/tmp/$SCRIPT_NAME.png" "$HOME/Downloads/$date/log/$filename" 2>&1 | cut -d' ' -f1)
		# echo $diff >> /tmp/diffs
		# echo .$diff. && sleep 1

		# if diff is more than 0.1
		if [ $(echo "$diff > 7500" | bc) -eq 1 ]; then
			echo $diff true >> /tmp/diffs
			same=true
			notify-send "true" "$diff"
			# run sendToDiscord
			sendToDiscord
		else
			echo $diff false >> /tmp/diffs
			same=false
			notify-send "false" "$diff"
			# update screenshot
			updateLastScreenshot
		fi
		
		mv "$HOME/Downloads/$date/log/$filename" "$HOME/Downloads/$date/log/$filename.$same.$diff"
	fi

	# check if PID file not exists
	if [ ! -f  /tmp/"$SCRIPT_NAME".pid ]; then
		exit 0
	fi

	sleep 1
done
