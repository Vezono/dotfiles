HEADPHONES_EMOJI="󰋋"

track=$(playerctl metadata --format "{{ artist }} - {{ title }}" 2> /dev/null)
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


text=$(echo "$track" | tr -s " ")
echo "$text"


