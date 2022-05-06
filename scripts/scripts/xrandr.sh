sel=$(printf "\
xrandr --output eDP-1 --auto --output HDMI-1 --auto --left-of eDP-1\n\
xrandr --output eDP-1 --auto --output HDMI-1 --auto --right-of eDP-1\n\
xrandr --output eDP-1 --auto --output HDMI-1 --off\n\
xrandr --output eDP-1 --off --output HDMI-1 --auto\
" | dmenu -l 3)

[ -n "$sel" ] && $sel
