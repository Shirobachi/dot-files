#!/bin/bash

options="Lock\nSleep\nLog out\nRestart\nShutdown"

choose=`echo -e $options | rofi -dmenu -p '🌈' -width 10 -lines 5 -display-drun ""`

case $choose in
  "Lock")
    i3lock-fancy -p 
    ;;

  "Sleep")
    systemctl suspend
    ;;

  "Log out")
    i3-msg exit
    ;;

  "Restart")
    killall chrome && sleep 1 && systemctl reboot
    ;;

  "Shutdown")
    killall chrome && sleep 1 && systemctl poweroff
    ;;
  esac
