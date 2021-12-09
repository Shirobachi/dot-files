#! /bin/bash

interface=$(pactl info | grep "Default Source" | cut -f3 -d" ")
interface=$(pactl list sources | grep -A10 "$interface" | grep "Mute" | cut -f2 -d" ")

# if interface is yes
if [ "$interface" == "yes" ]; then
	echo "MUTED!"
else
	echo "Mic is on"
fi
