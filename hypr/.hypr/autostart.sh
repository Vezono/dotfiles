#!/bin/bash
/home/vezono/.hypr/cleanup.sh

~/.hypr/s6-usertree/update-db.sh
s6-svscan ~/.s6/sv &
~/.hypr/s6-usertree/launch-tree.sh

swww img ~/Media/Wallpapers/minimal.jpg

wl-paste --watch cliphist store &

nm-applet &
nextcloud & 
kanshi -c ~/.hypr/kanshi.conf >> ~/.logs/kanshi &
sleep 3
XDG_SESSION_TYPE=x11 birdtray &
