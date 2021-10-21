#! /bin/bash

# Ask user what wallpaper to change to
options=$(ls /home/$USER/Wallpapers/cheatsheets)
lines=$(echo "$options" | wc -l)

# if lines > 10, set 10 as max
if [ $lines -gt 10 ]; then
	lines=10
fi

file=$(printf '%s\n' "${options[@]}" | rofi -dmenu -p "Choose wallpaper" -lines $lines -width 40)

# If file is not empty, exit
if [ -z "$file" ]; then
	exit
fi

# ask user for type of wallpaper
options=(
	"scale"
	"center"
	"fill"
	"scale"
	"max"
	"fill"
	"scale"
	"tile"
)

for option in "${options[@]}"; do
	# set wallpaper to $file with feh
	feh --bg-$option "/home/$USER/Wallpapers/$file"

	choose=$(echo -e "No\nYes" | rofi -dmenu -p "$option is ok" -lines 2 -width 40)

	# if user choose Yes, break
	if [ "$choose" == "Yes" ]; then
		break
	fi

done
