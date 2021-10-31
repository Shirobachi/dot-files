#! /bin/bash

# Ask user for strenght of password
strenght=(
	"a-z"
	"A-Z"
	"0-9"
	"a-zA-Z"
	"a-z0-9"
	"A-Z0-9"
	"a-zA-Z0-9"
	"a-zA-Z0-9\ \!#$%\&\'\(\)*+,-./:\;\<=\>?@[]^_\|{}~"
)

# Save user input
strenght=$(printf '%s\n' "${strenght[@]}" | rofi -dmenu -p "Choose password strenght" -lines ${#strenght[@]})

# if strenght is not set, exit
if [ -z "$strenght" ]; then
	exit
fi

# Ask user for length of password
lenght=(
	"8"
	"16"
	"24"
	"32"
	"48"
	"64"
)

# if lenght is not set, exit
if [ -z "$lenght" ]; then
	exit
fi

# if lenght set to "0-9"
if [ "$strenght" == "0-9" ]; then
	# add 4 to lenght array 

	lenght=(
		"4"
		${lenght[@]}
	)
fi

# Save user input
lenght=$(printf '%s\n' "${lenght[@]}" | rofi -dmenu -p "Choose password strenght" -lines ${#lenght[@]})

bash -cv "< /dev/urandom tr -dc $strenght | head -c${1:-$lenght} | xclip -selection clipboard && exit" &&
notify-send "`basename "$0"` " "Password copied to clipboard" ||
notify-send "`basename "$0"` -u critical " "Error happened during generating password!"