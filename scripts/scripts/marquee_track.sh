#!/usr/bin/env bash

# Constants and initializations
HEADPHONES_EMOJI="󰋋"
DISPLAY_LEN=40
REVERSE=0
PREV_TRACK=""
DISPLAY_TEXT=""

get_status_emoji() {
    # Check the player status using playerctl and return appropriate emoji
    if [ "$(playerctl status 2> /dev/null)" = "Playing" ]; then
        echo "󰏤"
    else
        echo "󰐊"
    fi
}

get_track() {
    # Get the current track using your track.sh script
    CURRENT_TRACK="$(~/scripts/track.sh)"
}

get_len() {
    # Get the length of a string
    local text="$@"
    echo ${#text}
}

# Initial track retrieval
get_track

while true; do
    get_track
    len=$(get_len "$CURRENT_TRACK")

    # Empty output if no track is playing
    if [ "$len" -eq 0 ]; then
        echo ""
        continue
    fi

    # Display track if it's shorter than the display length
    if [ "$len" -lt $((DISPLAY_LEN+5)) ]; then
        echo "<span color='#FDD835'>​<b>$HEADPHONES_EMOJI</b></span> $CURRENT_TRACK <span color='#FDD835'>​<b>$(get_status_emoji)</b></span>"
        continue
    fi

    text=$CURRENT_TRACK

    if [ "$l" -eq $((len)) ]; then
        (( l=0 ))
    else
        (( l = (l+1) % ${#text} ))
        if [ "$l" -eq 0 ]; then
            (( l=len ))
        fi
    fi

    (( l2 = (l - ${#text}) > 0 ? (l - ${#text}) : 0 ))
    (( w2 = (l + $DISPLAY_LEN - ${#text}) > 0 ? (l + $DISPLAY_LEN - ${#text}) : 0 ))

    DISPLAY_TEXT=$(printf '%s' "<span color='#FDD835'>​<b>$HEADPHONES_EMOJI</b></span>  ${text:$l:$DISPLAY_LEN} ${text:$l2:$w2} <span color='#FDD835'>​<b>$(get_status_emoji)</b></span>")

    # Print the formatted text
    echo "$DISPLAY_TEXT"

    # Sleep for a short duration
    sleep 0.1
done
