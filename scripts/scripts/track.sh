HEADPHONES_EMOJI="󰋋"

artist=$(playerctl metadata xesam:artist 2> /dev/null)
track=$(playerctl metadata xesam:title 2> /dev/null)
status=$(playerctl status 2> /dev/null)

if [[ "$status" == "" ]]; then
        echo
        exit
fi

if [[ "$status" == "Playing" ]]; then
        PLAYER_STATUS_EMOJI="󰏤"
    else
        PLAYER_STATUS_EMOJI="󰐊"
fi


text=$(echo "$artist - $track" | tr -s " ")
echo "$text"


