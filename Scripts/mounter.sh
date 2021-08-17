#! /bin/bash

list=""

if [ -d ~/phone ]; then
  list="Yes\nNo"

  ans=`echo -e "$list" | rofi -dmenu -p "Do you want to unmount phone"`

  if [ "$ans" == "Yes" ]; then
    umount ~/phone/ &&
    rm -r ~/phone/ && 
    notify-send 'Phone unmounted!'
  fi

  else
    for i in {0..255}; do
      if [ $i == "255" ]; then
        list="${list}$i"
      else
        list="${list}$i\n"
      fi
    done

    var=`echo -e "$list" | rofi -dmenu -p "Last octet"`

    if [ "$var" != "" ]; then
      mkdir -p ~/phone

      `curlftpfs anonymous@192.168.0.$var:2121 ~/phone` &&
      notify-send "Phone mounted!"
    fi
fi 

find ~ -name phone -type d -empty -delete