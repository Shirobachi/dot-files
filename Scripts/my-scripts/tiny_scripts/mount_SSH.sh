#! /bin/bash

# get hosts from .ssh/config
hosts=$(grep -oE 'Host [^ ]+' /home/$USER/.ssh/config | grep -oE '[^ ]+$')

# remove github and gitlab hostrs
hosts=$(echo "$hosts" | grep -vE 'github|gitlab')
lines=$(echo "$hosts" | wc -l)

for host in $hosts; do
	if [ -d /home/$USER/SSH/$host ]; then
		hosts2=$hosts2"UNMOUNT "$host"\n"
	else
		hosts2=$hosts2"MOUNT "$host"\n"
	fi
done

# replace hosts with hosts2
hosts=${hosts2::-2}

# get input from user by rofi
input=$(echo -e "$hosts" | rofi -dmenu -p "SSH to" -lines $lines -width 20)

# if input is empty, exit
if [ -z "$input" ]; then
	notify-send "SSH" "No host selected"
	exit
fi

# if awk $1 == "MOUNT"
if [[ $input == "MOUNT"* ]]; then
	# check if sshfs is installed
	if [ ! -x "$(command -v sshfs)" ]; then
		notify-send "SSH" "sshfs is not installed, installing..."
		gnome-terminal -- /bin/bash -c "sudo apt install sshfs && sudo groupadd fuse && usermod -a -G fuse $USER && echo 'All good, press ENTER to close terminal' && read"
		# exit if error occured
		if [ $? -ne 0 ]; then
			echo "sudo apt install sshfs && sudo groupadd fuse && usermod -a -G fuse $USER" | xclip -selection clipboard
			notify-send "SSH" "Error occured use command from your clipboard to install dependencies"
			exit
		fi
	fi

	# Check if /etc/fuse.conf:8 is commented
	if [[ $(cat /etc/fuse.conf | sed -n "8p" | grep -c "#") == 1 ]]; then
		notify-send "SSH" "fuse.conf:8 is commented, commenting out..."

		# uncomment /etc/fuse.conf:8
		gnome-terminal -- /bin/bash -c 'sudo sed -i "8s/^\s*#\s*//" /etc/fuse.conf && echo "All good, press ENTER to close terminal" && read'
		if [ $? -ne 0 ]; then
			echo 'sed -i "7s/^\s*#\s*//" /etc/fuse.conf' | xclip -selection clipboard
			notify-send "SSH" "Error occured use command from your clipboard to uncoment /etc/fuse.conf:8"
			exit
		fi
	fi

	# input = input | awk $2 
	input=$(echo "$input" | awk '{print $2}')

	# get all informations about $input from .ssh/config
	host=$(cat /home/$USER/.ssh/config | sed -n "/Host $input/,/^$/p")

	# if host is empty, notify and exit
	if [ -z "$host" ]; then
		notify-send "SSH" "No host found!"
		exit
	fi

	# remove first line from user
	host=$(echo "$host" | sed -n '2,$p')

	# set hostname
	hostName=$(echo "$host" | grep -oE 'HostName [^ ]+' | grep -oE '[^ ]+$')

	# ping host, if not pingable, notify and exit
	ping -c 1 $hostName > /dev/null
	if [ $? -ne 0 ]; then
		notify-send "SSH" "Host $hostName is not pingable!"
		exit
	fi

	# set port
	port=$(echo "$host" | grep -oE 'Port [^ ]+' | grep -oE '[^ ]+$')

	# if port is empty, set default port
	port=${port:-22}

	# set user
	user=$(echo "$host" | grep -oE 'User [^ ]+' | grep -oE '[^ ]+$')

	# set identity file
	identity=$(echo "$host" | grep -oE 'IdentityFile [^ ]+' | grep -oE '[^ ]+$')

	# check if file exist, if not then empty string
	if [ ! -f "$identity" ]; then
		# notidy that identity file is not found, exit
		notify-send "SSH" "Identity file $identity is not found!"
		exit
	fi

	# if identity file is empty, mount ssh without identity file
	if [ -z "$identity" ]; then
		# Notify that non indentity file server are not supported, exit
		notify-send "SSH" "Non indentity file server are not supported!"
		exit
	else
		# prepaire directory mkdir
		mount_point=/home/${USER}/SSH/${input}
		mkdir -p $mount_point
		
		sshfs -o allow_other,IdentityFile=$identity,port=$port $user@$hostName:/ $mount_point || notify-send "SSH" "Mount failed trying with password"

		# if mount failed, try with password
		if [ $? -ne 0 ]; then
			# notify about error
			notify-send -u critical "SSH" "Mount failed"
			exit
		fi
	fi
else
	# input = input | awk $2 
	input=$(echo "$input" | awk '{print $2}')

	# check if /home/$USER/SSH/$input exist
	if [ ! -d /home/$USER/SSH/$input ]; then
		notify-send "SSH" "No mount point found!"
		exit
	fi

	# unmount
	umount /home/$USER/SSH/$input && 
	rmdir /home/$USER/SSH/$input || 
	notify-send "SSH" "Unmount failed!"

	# check if /home/$USER/SSH is empty
	if [ -z "$(ls -A /home/$USER/SSH)" ]; then
		rmdir /home/$USER/SSH
	fi
fi