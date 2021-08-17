#! /bin/bash
# set -x
export DISPLAY=:0.0

# true - delete, else - move
function process(){
	if [ "$2" = "DELETE" ]; then
		rm -r "$1" && notify-send "$3 $1 deleted!"
	else
    mv "$1" "../.Downloads/$1" && notify-send "$3 $1 moved to ~/.Downloads/$1!"
	fi
}

# remove empty directories
for emptyDir in `find ~/Desktop/ ~/Downloads/ -empty -type d`; do
	notify-send "Directoy $emptyDir was deleted, because was empty!"
done
find ~/Desktop/ ~/Downloads/ -empty -type d -delete

# remove / move old files / directorie
if [ -z "$1" ] || [ "${1,,}" != "delete" ] && [ "${1,,}" != "move" ]; then
	echo "Give as parameter mode ( delete / move )"
	exit
fi

if [ "${1,,}" == "delete" ]; then
	day=30
	path=".Downloads"
	mode="DELETE"
else
	day=2
	path="Downloads"
	mode="MOVE"
  cr  
  if [ ! -d "~/.Downloads" ]; then
    mkdir -p ~/.Downloads
  fi
fi

cd ~/$path

for element in *
do
	if [ -d "$element" ]; then
		if [ $(find "$element" -type f -mtime -$day | wc -l) -eq 0 ]; then
			process "$element" "$mode" "Directory"
		fi
	else
		if [ $(find `pwd` -name "$element" -mtime +$day | wc -l) -gt 0 ]; then
			process "$element" "$mode" "File"
		fi
	fi
done
