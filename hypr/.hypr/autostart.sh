#!/bin/bash
nm-applet &
~/.hypr/scripts/swhkd.sh &
~/.hypr/waybar/launch.sh
swww-daemon &
dunst &

swww img ~/Media/Wallpapers/minimal.jpg