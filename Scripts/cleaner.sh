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
files=0
dirs=0

# loop through files
for file in *; do
	# check if file is a directory
	if [ -d "$file" ]; then
		# check if folder is older than days - 1
		if [ ! "$(find "$(printf '%q' "$file")" -mtime -$(($3 - 1)))" ]; then
			# delete/mode folder
			if [ "$1" == "delete" ]; then
				rm -rf "$file"
			else
				mv -f "$file" "$HOME/.$2"
			fi
			# increment count
			dirs=$((dirs+1))
		fi
	else
		# check if file is older than days - 1
		if [ "$(find . -name "$(printf '%q' "$file")" -mtime +$(($3 - 1)))" ]; then
			# delete/mode file
			if [ "$1" == "delete" ]; then
				rm -f "$file"
			else
				mv -f "$file" "$HOME/.$2"
			fi
			# increment count
			files=$((files+1))
		fi
	fi
done

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# Make message
# If files = 0 and dirs = 0, then empty message
if [ "$files" -eq 0 ] && [ "$dirs" -eq 0 ]; then
	message=""
# else if files = 0 and dirs > 0, then message = "$dirs directories"
elif [ "$files" -eq 0 ] && [ "$dirs" -gt 0 ]; then
	message="$dirs directorie(s)"
# else if files > 0 and dirs = 0, then message = "$files files"
elif [ "$files" -gt 0 ] && [ "$dirs" -eq 0 ]; then
	message="$files file(s)"
# else if files > 0 and dirs > 0, then message = "$files files and $dirs directories"
else
	message="$files file(s) and $dirs directorie(s)"
fi

# if dir > 0 or file > 0, then notify-send message
if [ "$files" -gt 0 ] || [ "$dirs" -gt 0 ]; then
	# if mode is move
	if [ "$1" == "move" ]; then
		notify-send "`basename "$0"`" "Moved $message"
	else
		# notify
		notify-send "`basename "$0"`" "Deleted $message" -u critical
	fi
fi