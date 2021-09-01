#! /bin/bash

# This script is used as menu for some scripts.
# Showing the menu and getting the user input.
# Make array of menu items.
menu=(
	"Mount your phone (FTP)"
	"(Un)mount USB"
	"(Un)moung SSH"
	"Password generator"
)

# Save input from rofi
input=$(printf '%s\n' "${menu[@]}" | rofi -dmenu -i -p "Script" -width 20 -lines ${#menu[@]}) 

# ================== Mounter ==================

# if user input is "Mounter"
if [[ $input == "${menu[0]}" ]]; then
	# run script
	bash /home/${USER}/Scripts/tiny_scripts/mount_phone.sh
elif [[ $input == "${menu[1]}" ]]; then
	# run script
	bash /home/${USER}/Scripts/tiny_scripts/mount_USB.sh
elif [[ $input == "${menu[2]}" ]]; then
	# run script
	bash /home/$USER/Scripts/tiny_scripts/mount_SSH.sh
elif [[ $input == "${menu[3]}" ]]; then
	# run script
	bash /home/${USER}/Scripts/tiny_scripts/password_generator.sh
fi