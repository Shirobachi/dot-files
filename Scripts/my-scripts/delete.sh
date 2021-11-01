#! /bin/bash

# if $HOME/.Downloads/ not exists, delete it
if [ ! -d "$HOME/.Downloads" ]; then
	rm -rf "$@"
fi

# for all arguments
for arg in "$@"; do
	# if $arg is file / directory
	if [ -e "$arg" ]; then
		if [ -e "$HOME/.Downloads/$arg" ]; then
			mv "$arg" "$HOME/.Downloads/$RANDOM|$arg"
		else
			mv "$arg" "$HOME/.Downloads"
		fi
	fi
done

