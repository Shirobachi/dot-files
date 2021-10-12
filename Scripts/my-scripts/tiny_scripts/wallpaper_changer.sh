#! /bin/bash

# Ask user what wallpaper to change to
options=$(ls /home/$USER/Wallpapers)
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

type=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Type of wallpaper" -width 20 -lines ${#options[@]}) 

# set wallpaper to $file with feh
feh --bg-$type "/home/$USER/Wallpapers/$file"