#!/bin/sh

export DISPLAY=:0.0
export temperature=`for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $i"; done | tail -2 | head -1 | cut -d " " -f 4`
notify-send "Reloading ..."

# Get possition from $HOME/Documents/.env/external_screen_possition
possition=$(cat "$HOME"/Documents/.env/external_screen_possition)

# if possition is empty set it above
if [ -z "$possition" ]; then
	possition="above"
fi

# set screen setup
xrandr | cut -d " " -f1 | xargs -I{} xrandr --output {} --off
xrandr | grep -i " connected" | cut -d " " -f1 | xargs -I{} xrandr --output {} --auto
if [ $(xrandr | grep " connected" | wc -l) -gt 1 ]; then
	xrandr --output "DP-0" --auto --$possition "DP-2"
  #xrandr --output "DP-0" --mode 1440x900
fi

# restart services and new wallpaper
feh --randomize --bg-fill ~/Wallpapers/*
sleep .3 && /home/simon/.config/polybar/launch.sh
i3-msg restart
libinput-gestures-setup restart

killall dunst
