#! /bin/bash

if [ "$input" == "${options[0]}" ]; then
	options=`lsblk -rpo "name,size,mountpoint" | grep /dev/sd | awk '{{printf ($3==""?"":"UN")"MOUNT %s (%s)\n",$1,$2}}'`
	lines=`echo -e "$options" | wc -l`

	# if options is empty string, send notification and exit
	if [ -z "$options" ]; then
		notify-send "No USB drive found"
		exit 1
	fi

	# if lines > 10, then chenge lines to 10
	if [ $lines -gt 10 ]; then
		lines=10
	fi

	input=`echo -e "$options" | rofi -dmenu -p 'Select USB' -lines $lines -width 20`

	# exit if input is empty
	if [ -z "$input" ]; then
		notify-send "Cancelled"
		exit
	fi

	# exit if input not include in options
	if [[ ! `echo "$options" | grep "$input"` ]]; then
		notify-send -u critical "Wrong input"
		exit 1
	fi

	# get mount point
	mount_point=`echo "$input" | awk '{print $2}'`

	echo $mount_point

	# if mount point is empty, send notification and exit
	if [ -z "$mount_point" ]; then
		notify-send -u critical "No mount point"
		exit 1
	fi

	if [[ `echo $input | awk '{print $1}'` == "MOUNT" ]]; then
		# mount USB
		udisksctl mount --no-user-interaction -b $mount_point && 
		notify-send "Mounted" || 
		notify-send -u critical "Failed to mount"
	else
		# unmount USB
		udisksctl unmount --no-user-interaction -b $mount_point &&
		notify-send "Unmounted" ||
		notify-send -u critical "Failed to unmount!"
	fi
fi