#!/bin/bash

# make an array with options
sure=( "Sure" "Are you sure" "RU sure" "Do it" "We do it" "Really" )
yes=( "Yes" "Yeah" "HELLL YEAH" "OH YEAH" "OFC BABy" "non't" )
no=( "No" "Nope" "Nah" "Naw" "Nawww" "Nawwwww" )

# make randomized options
randomChoice=$((RANDOM%6))
yes=${yes[$randomChoice]}
no=${no[$randomChoice]}
sure=${sure[$randomChoice]}

# Function to save layout 
function saveLayout() {
	# Remove old layout
	rm -rf $HOME/.i3 $HOME/.config/i3-resurrect

	# for 0..9
	for i in {0..9}; do
		# save layout
		i3-resurrect save -w $i -d $HOME/.i3

		# check if file $HOME/.i3/workspace_${i}_programs.json has less or equal than 2b and check if file $HOME/.i3/workspace_${i}_layout.json has less or equal than 2b
		if [ $(wc -c < $HOME/.i3/workspace_${i}_programs.json) -le 2 ] && [ $(wc -c < $HOME/.i3/workspace_${i}_layout.json) -le 2 ]; then
			# remove file $HOME/.i3/workspace_${i}_programs.json and $HOME/.i3/workspace_${i}_layout.json
			rm $HOME/.i3/workspace_${i}_programs.json 2>/dev/null
			rm $HOME/.i3/workspace_${i}_layout.json 2>/dev/null
		fi
	done
}

# Function to restore layout
function restoreLayout() {
	# for 0..9
	for i in {0..9}; do
		# check if file $HOME/.i3/workspace_${i}_programs.json and $HOME/.i3/workspace_${i}_layout.json exists
		if [ -f $HOME/.i3/workspace_${i}_programs.json ] && [ -f $HOME/.i3/workspace_${i}_layout.json ]; then
			# restore layout
			i3-resurrect restore -w $i -d $HOME/.i3
		fi
	done

	# Go to 1st workspace
	i3-msg workspace 1

	# if ps -A | grep "chrome" | wc -l < 0
	if [ $(ps -A | grep "chrome" | wc -l) -le 0 ]; then
		# Launch google-chrome on 1st workspace
		google-chrome
	fi
}

# ----------------------------------------------------------------------------------------------------------------------

# Flags
# if one parameter is passed and it is "--restart" or "-r"
if [ $# -eq 1 ] && [ "$1" == "--restart" ] || [ "$1" == "-r" ] && [ "`echo -e \"$yes\n$no\" | rofi -dmenu -p \"$sure\" -width 10 -lines 2`" == "$yes" ]; then
	notify-send "Restarting..."

	# save layout
	`dirname "$0"`/`basename "$0"` -sl|| notify-send basename "$0" "Error during saving layout"
	killall chrome
	sleep 1 && systemctl reboot

# if one parameter is passed and it is "--poweroff" or "-p"
elif [ $# -eq 1 ] && [ "$1" == "--poweroff" ] || [ "$1" == "-p" ] && [ "`echo -e \"$yes\n$no\" | rofi -dmenu -p \"$sure\" -width 10 -lines 2 $(basename2 "$0")`" == "$yes" ]; then
	notify-send "Shutdowning..."

	# save layout
	`dirname "$0"`/`basename "$0"` -sl|| notify-send basename "$0" "Error during saving layout"
	killall chrome
	sleep 1 && systemctl poweroff

# if one parameter is passed and it is "--exit" or "-e"
elif [ $# -eq 1 ] && [ "$1" == "--exit" ] || [ "$1" == "-e" ] && [ "`echo -e \"$yes\n$no\" | rofi -dmenu -p \"$sure\" -width 10 -lines 2 $(basename2 "$0")`" == "$yes" ]; then
	notify-send "Logout..."

	# save layout
	`dirname "$0"`/`basename "$0"` -sl|| notify-send basename "$0" "Error during saving layout"
	killall chrome
	sleep 1 && i3-msg exit

# if one parameter is passed and it is "--lock" or "-l"
elif [ $# -eq 1 ] && [ "$1" == "--lock" ] || [ "$1" == "-l" ]; then
	i3lock-fancy -p

# if one parameter is passed and it is "--save-layout" or "-sl"
elif [ $# -eq 1 ] && [ "$1" == "--save-layout" ] || [ "$1" == "-sl" ]; then
	# run saveLayout()
	saveLayout && exit 0 || notify-send -u critical "`basename "$0"`" "Could not save layout!"

# if one parameter is passed and it is "--restart-layout" or "-rl"
elif [ $# -eq 1 ] && [ "$1" == "--restart-layout" ] || [ "$1" == "-rl" ]; then
	# run restoreLayout()
	restoreLayout && exit 0 || notify-send -u critical "`basename "$0"`" "Could not restore layout!"

# else or -h or --help
else
	echo Wrong parameter!
	echo "Usage: `basename "$0"` [--restart|-r] [--poweroff|-p] [--exit|-e] [--lock|-l] [--save-layout|-s]"
	exit 1
fi