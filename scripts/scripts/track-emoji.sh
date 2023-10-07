artist=$(playerctl metadata | grep artist)
artist=${artist#*xesam:artist}
#artist=$(echo $artist | head --bytes=20)
artist=$(echo $artist)

track=$(playerctl metadata | grep title)
track=${track#*xesam:title}

#track=$(echo $track | head --bytes=21)
track=$(echo $track)

status=$(playerctl status)

if [[ "$status" == "Playing" ]]; then
        PLAYER_STATUS_EMOJI="󰏤"
    else
        PLAYER_STATUS_EMOJI="󰐊"
    fi

if [[ "$track" == "" ]]; then
        text=""
    else
        text=$(echo "󰋋 $artist - $track" | tr -s " ")
    fi

echo $PLAYER_STATUS_EMOJI


