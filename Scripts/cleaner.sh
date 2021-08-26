#! /bin/bash
#set -x
export DISPLAY=:0.0

# Arguments: 
# $1: mode (delete or move)
# $2: path to the folder to clean
# $3: number of days to delete/move

# Chceck arguments
if [ $# -ne 3 ]; then
	notify-send "Usage: $0 <mode> <path> <days>"
	exit 1
fi

# Check mode
if [ "$1" != "delete" ] && [ "$1" != "move" ]; then
	notify-send "Mode must be delete or move"
	exit 1
fi

# Check path
if [ ! -d "$HOME/$2" ]; then
	notify-send "Path does not exist in your home directory"
	exit 1
fi

# Check days
if [ "$3" -lt 1 ] || [ "$3" -gt 365 ]; then
	notify-send "Days must be between 1 and 365"
	exit 1
fi

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Go to the folder
cd $HOME/$2

# Make variable count
count=0

# loop through files
for file in *; do
	# check if file is a directory
	if [ -d "$file" ]; then
		# check if folder is older than days - 1
		if [ ! "$(find "$(printf '%q' "$file")" -type f -mtime -$(($3 - 1)))" ]; then
			# delete/mode folder
			if [ "$1" == "delete" ]; then
				rm -rf "$file"
			else
				mv "$file" "$HOME/.$2"
			fi
			# increment count
			count=$((count+1))
			echo "$file"
		fi
	else
		# check if file is older than days
		if [ "$(find . -name "$(printf '%q' "$file")" -type f -mtime +$(($3 - 1)))" ]; then
			# delete/mode file
			if [ "$1" == "delete" ]; then
				rm "$file"
			else
				mv "$file" "$HOME/.$2"
			fi
			# increment count
			count=$((count+1))
			echo "$file"
		fi
	fi
done

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# notify if counte is grater than 0
if [ "$count" -gt 0 ]; then
	# if mode is move
	if [ "$1" == "move" ]; then
		notify-send "`basename "$0"`" "Moved $count files and/or directories"
	else
		# notify
		notify-send "`basename "$0"`" "Deleted $count files and/or directories" -u critical
	fi
fi