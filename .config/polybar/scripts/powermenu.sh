#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="$HOME/.config/polybar/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/launcher.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
logout=" Logout"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
      killall google-chrome
			Scripts/my-scripts/sessionManager.sh -s && 
			systemctl poweroff
        ;;
    $reboot)
      killall google-chrome
			Scripts/my-scripts/sessionManager.sh -s && 
			systemctl reboot
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock-fancy ]]; then
			i3lock-fancy -p
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $suspend)
			mpc -q pause
			amixer set Master mute
			Scripts/my-scripts/sessionManager.sh -s && 
			systemctl suspend
        ;;
    $logout)
      killall google-chrome
			Scripts/my-scripts/sessionManager.sh -s && 
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			fi
			;;
esac
