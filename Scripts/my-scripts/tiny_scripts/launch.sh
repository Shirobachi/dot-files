#! /bin/bash

# This script is used as menu for some scripts.
# Showing the menu and getting the user input.
# Make array of menu items.

# Get script dir
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

menu=(
	"Mount your phone (FTP)"
	"(Un)mount USB"
	"(Un)moung SSH"
	"Password generator"
	"Change wallpaper"
	"Random cool wallpaper"
)

# Save input from rofi
input=$(printf '%s\n' "${menu[@]}" | rofi -dmenu -i -p "Script" -width 20 -lines ${#menu[@]} -theme $HOME/.config/polybar/scripts/rofi/launcher.rasi) 

# ================== Mounter ==================

# if user input is "Mounter"
if [[ $input == "${menu[0]}" ]]; then
	# run script
	bash $SCRIPT_DIR/mount_phone.sh
elif [[ $input == "${menu[1]}" ]]; then
	# run script
	bash $SCRIPT_DIR/mount_USB.sh
elif [[ $input == "${menu[2]}" ]]; then
	# run script
	bash $SCRIPT_DIR/mount_SSH.sh
elif [[ $input == "${menu[3]}" ]]; then
	# run script
	bash $SCRIPT_DIR/password_generator.sh
elif [[ $input == "${menu[4]}" ]]; then
	# run script
	bash $SCRIPT_DIR/wallpaper_changer.sh
elif [[ $input == "${menu[5]}" ]]; then
	# run random wallpaper
	feh --randomize --bg-fill ~/Wallpapers/wallpapers
fi