#!/bin/bash
~/scripts/s6kill.sh

~/.hypr/s6-usertree/update-db.sh
s6-svscan ~/.s6/sv &
~/.hypr/s6-usertree/launch-tree.sh

swww img ~/Media/Wallpapers/minimal.jpg

pipewire &
pipewire-pulse &
wireplumber &

wl-paste --watch cliphist store &

nm-applet &
~/.hypr/waybar/launch.sh
nextcloud & 
kanshi -c ~/.hypr/kanshi.conf &
sleep 3
XDG_SESSION_TYPE=x11 birdtray &