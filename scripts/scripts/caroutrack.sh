#!/bin/bash

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
    CURRENT_TRACK=$(~/scripts/track.sh)
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

    # Display track if it's shorter than the display length
    if [ "$len" -lt "$DISPLAY_LEN" ]; then
        echo "%{F#FDD835}$HEADPHONES_EMOJI%{F-} $CURRENT_TRACK %{F#FDD835}$(get_status_emoji)"
        continue
    fi

    # Initialize cut positions if the track has changed
    if [ "$PREV_TRACK" != "$CURRENT_TRACK" ]; then
        LEFT_CUT=0
        RIGHT_CUT=$((len - DISPLAY_LEN))
        PREV_TRACK="$CURRENT_TRACK"
    fi

    if [ "$REVERSE" -eq 0 ]; then
        ((LEFT_CUT++))
        ((RIGHT_CUT--))
        # Switch to reverse scrolling if needed
        if [ "$LEFT_CUT" -ge $((len - DISPLAY_LEN)) ]; then
            REVERSE=1
        fi
    else
        if [ "$LEFT_CUT" -le 1 ]; then
            REVERSE=0
        fi
        ((LEFT_CUT--))
        ((RIGHT_CUT++))
    fi

    # Create the text to display
    DISPLAY_TEXT="${CURRENT_TRACK:${LEFT_CUT}}"
    if [ "$RIGHT_CUT" -gt 0 ] && [ $(get_len "$DISPLAY_TEXT") -gt $RIGHT_CUT ]; then
        DISPLAY_TEXT="${DISPLAY_TEXT:0:-${RIGHT_CUT}}"
    fi

    # Print the formatted text
    echo "%{F#FDD835}$HEADPHONES_EMOJI%{F-} $DISPLAY_TEXT %{F#FDD835}$(get_status_emoji)"

    # Sleep for a short duration
    sleep 0.1
done
