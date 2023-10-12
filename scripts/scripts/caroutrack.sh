#!/bin/bash

HEADPHONES_EMOJI="󰋋"
DISPLAY_LEN=40

LEFT_CUT=0
RIGHT_CUT=0

REVERSE=0

PREV_TRACK=""

get_status_emoji() {
    if [ "$(playerctl status 2> /dev/null)" = "Playing" ]; then
            echo "󰏤"
        else
            echo "󰐊"
    fi
}

get_track() {
    CURRENT_TRACK=`~/scripts/track.sh`
}

get_len() {
    local text="$@"
    echo ${#text}
}

get_track

while true
do
    get_track
    len=$(get_len $CURRENT_TRACK)

    if [ "$len" -lt "$DISPLAY_LEN" ]; then
        echo "%{F#FDD835}$HEADPHONES_EMOJI%{F-} $CURRENT_TRACK %{F#FDD835}$(get_status_emoji)"
        continue
    fi

    if [ "$PREV_TRACK" != "$CURRENT_TRACK" ]; then
        LEFT_CUT=0
        RIGHT_CUT=$((len - DISPLAY_LEN))
        PREV_TRACK="$CURRENT_TRACK"
    fi

    if [ "$REVERSE" -eq 0 ]; then
        ((LEFT_CUT++))
        ((RIGHT_CUT--))
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

    DISPLAY_TEXT="${CURRENT_TRACK:${LEFT_CUT}}"
    if [ "$RIGHT_CUT" -gt 0 ] && [ $(get_len $DISPLAY_TEXT) -gt $RIGHT_CUT ]; then
       DISPLAY_TEXT="${DISPLAY_TEXT:0:-${RIGHT_CUT}}"
    fi

    echo "%{F#FDD835}$HEADPHONES_EMOJI%{F-} $DISPLAY_TEXT %{F#FDD835}$(get_status_emoji)"
    sleep 0.1
done


