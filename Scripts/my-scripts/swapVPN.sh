#!/bin/bash

VPN="chop-chop2"

network_ID=$(nmcli connection show | grep "$VPN" | awk '{print $4}')
VPN_ID=$(nmcli con | grep "$VPN" | awk '{print $2}')

#if network_ID is '--' then the VPN is not connected
if [ "$network_ID" = "--" ]; then
    notify-send "VPN" "Conecting VPN . . .";
    nmcli con up "$VPN_ID" &&
    killall dunst &&
    sleep .5 &&
    notify-send "VPN" "Connected"
else
    notify-send "VPN" "Disconecting VPN . . .";
    nmcli con down "$VPN_ID" &&
    killall dunst &&
    sleep .5 &&
    notify-send "VPN" "Disconnected"
fi