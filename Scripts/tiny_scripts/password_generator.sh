#! /bin/bash

function generate_password() {
	
}

# Ask user for strenght of password
strenght=(
	"a-z"
	"A-Z"
	"0-9"
	"a-zA-Z"
	"a-z0-9"
	"A-Z0-9"
	"a-zA-Z0-9"
	"a-zA-Z0-9+"
)

# Save user input
strenght=$(printf '%s\n' "${strenght[@]}" | rofi -dmenu -p "Choose password strenght" -lines ${#strenght[@]} )

# Ask user for length of password
lenght=(
	"8"
	"16"
	"24"
	"32"
	"48"
	"64"
)

# Save user input
lenght=$(printf '%s\n' "${lenght[@]}" | rofi -dmenu -p "Choose password strenght" -lines ${#lenght[@]} )

echo generate_password $strenght $lenght