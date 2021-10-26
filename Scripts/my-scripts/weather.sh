#!/bin/bash

if [ $# -lt 2 ] || [ $# -gt 3 ] ; then
	echo 'Wrong parameters!'
	# $1=Town name
	# $2=API KEY
	exit 2
elif [ $# -eq 2 ]; then
	# show on polybar
	respond=`curl -s "https://api.openweathermap.org/data/2.5/forecast?q=$1&appid=$2&units=metric"`
	if [[ $? -eq 0 ]]; then
		temp=`echo $respond | jq '.list[0].main.temp'`
		desc=`echo $respond | jq '.list[0].weather[0].main'`; desc=${desc::-1}; desc=${desc:1}
		echo "$temp°C - $desc"
	else
		echo "-1"
	fi
else
	# notifications on click
	# $3=anything 
	respond=`curl -s "https://api.openweathermap.org/data/2.5/forecast?q=$1&appid=$2&units=metric"`

	for i in {0..4}; do

		let index=(40/5)*i

		title=`echo $respond | jq ".list[$index].dt_txt"`; title=${title::-1}; title=${title:1}

		description=`echo $respond | jq ".list[$index].weather[0].main"`; description=${description::-1}; description=${description:1}
		temp=`echo $respond | jq ".list[$index].main.temp"`
		humidity=`echo $respond | jq ".list[$index].main.humidity"`

		message="Descrition: $description\nTemperature: $temp°C\nHumidity: $humidity%"

		notify-send "$title$i" "$message"

	done
fi
