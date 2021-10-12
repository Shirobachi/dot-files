#!/bin/bash
export DISPLAY=:0.0

if pgrep -x xcompmgr; then
  killall xcompmgr
  notify-send "xcompmgr killed!"
else
  xcompmgr &
  notify-send "xcompmgr runned!"
fi
