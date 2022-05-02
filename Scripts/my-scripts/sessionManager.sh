#!/bin/bash

# Function to save layout 
function saveLayout() {
	# Save current layout
	export DISPLAY=:0
	notify-send "Saving layout ..."

    # Try to turn off LEDS
    curl -s http://wled.local/win&T=0;

	# Send config changes to GH
	/usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon commit -am "Auto backup!"
	/usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon pull
	/usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon push

	# Remove old layout
	rm -rf "$HOME/.i3" "$HOME/.config/i3-resurrect"

	# for 0..9
	for i in {0..9}; do
		# save layout
		i3-resurrect save -w $i -d "$HOME/.i3"

		# check if file $HOME/.i3/workspace_${i}_programs.json has less or equal than 2b and check if file $HOME/.i3/workspace_${i}_layout.json has less or equal than 2b
		if [ "$(wc -c < "$HOME/.i3/workspace_${i}_programs.json")" -le 2 ] && [ "$(wc -c < "$HOME/.i3/workspace_${i}_layout.json")" -le 2 ]; then
			# remove file $HOME/.i3/workspace_${i}_programs.json and $HOME/.i3/workspace_${i}_layout.json
			rm "$HOME/.i3/workspace_${i}_programs.json" 2>/dev/null
			rm "$HOME/.i3/workspace_${i}_layout.json" 2>/dev/null
		fi
	done

	# remove notification and show new
	killall -q dunst
	notify-send "Layout saved"
}

# Function to restore layout
function restoreLayout() {
	# Restore layout
	export DISPLAY=:0
	notify-send "Restoring layout ..."

	# for 0..9
	for i in {0..9}; do
		# check if file $HOME/.i3/workspace_${i}_programs.json and $HOME/.i3/workspace_${i}_layout.json exists
		if [ -f "$HOME/.i3/workspace_${i}_programs.json" ] && [ -f "$HOME/.i3/workspace_${i}_layout.json" ]; then
			# restore layout
			i3-resurrect restore -w "$i" -d "$HOME/.i3"
		fi
	done

	# Go to 1st workspace
	i3-msg workspace 1

	# if ps -A | grep "chrome" | wc -l < 0
	if [ "$(pgrep -f "chrome" | wc -l)" -le 0 ]; then
		# Launch google-chrome on 1st workspace
		google-chrome
	fi

	# remove notification and show new
	killall -q dunst
	notify-send "Layout restored"
}

# ----------------------------------------------------------------------------------------------------------------------

# if $1 -r or --restore
if [ "$1" = "-r" ] || [ "$1" = "--restore" ]; then
	# Restore layout
	restoreLayout
# else if -s or --save
elif [ "$1" = "-s" ] || [ "$1" = "--save" ]; then
	# Save layout
	saveLayout
else
	# Print usage
	echo "Usage: sessionManager.sh [OPTION]"
	echo "Options:"
	echo "  -r, --restore  Restore layout"
	echo "  -s, --save     Save layout"
fi
