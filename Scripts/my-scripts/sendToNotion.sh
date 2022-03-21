#! /bin/bash

input=$(echo '' | rofi -dmenu -i -p "Send to notion: " -lines 0 -theme $HOME/.config/polybar/scripts/rofi/message.rasi) 
input=${input// / }

data="{\"parent\":{\"database_id\":\"`cat $HOME/.env/notion-db-id | head -1`\"},\"properties\":{\"Name\":{\"title\":[{\"text\":{\"content\":\""$input"\"}}]}}}"

#if input no empty
if [ -n "$input" ]; then
curl 'https://api.notion.com/v1/pages' \
	-H 'Authorization: Bearer '"`cat $HOME/.env/API-notion`"'' \
	-H "Content-Type: application/json" \
	-H "Notion-Version: 2021-08-16" \
	--data $data || notify-send "Error" "Could not create page"
fi
