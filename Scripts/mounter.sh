#! /bin/bash

# This script is used as menu for some scripts.
# Showing the menu and getting the user input.
# Make array of menu items.
menu=(
	"Mounter"
)

# Save input from rofi
input=$(echo -e "${menu[@]}" | rofi -dmenu -i -p "Script") 

# ================== Mounter ==================

# if user input is "Mounter"
if [[ $input == "${menu[0]}" ]]; then
	# Check if phone is mounted already
	if [ -d /home/${USER}/Phone ]; then
		# Ask user if he want to unmount
		input=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Unmount phone?")

		# if user input is "Yes"
		if [[ $input == "Yes" ]]; then
			# unmount phone
			umount /home/${USER}/Phone && 
			rm -rf /home/${USER}/Phone &&
			notify-send "Phone unmounted" || 
			notify-send -u critical "Unmount failed!"
		fi
	else # if phone is not mounted
		# Prepaire list of numbers
		for i in {1..254}; do
			list="$list$i\n"
		done
		list="$list"255

		# Ask user for number
		input=`echo -e "$list" | rofi -dmenu -p "Last octet"`

		# if user input is not empty
		if [ "$input" != "" ]; then
			mkdir -p /home/${USER}/Phone

			curlftpfs anonymous@192.168.0.$input:2121 /home/${USER}/Phone &&
			notify-send "Phone mounted!" ||
			notify-send -u critical "Mount failed!"
		fi
	fi
fi