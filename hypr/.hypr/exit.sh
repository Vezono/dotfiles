#!/bin/sh
echo "Hyprland exited on $(date)" > ~/.logs/hyprexit
/home/vezono/.hypr/cleanup.sh
hyprctl dispatch exit
