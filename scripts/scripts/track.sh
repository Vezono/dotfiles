artist=$(playerctl metadata | grep artist)
artist=${artist#*xesam:artist}
artist=$(echo $artist | head --bytes=20)

track=$(playerctl metadata | grep title)
track=${track#*xesam:title}

track=$(echo $track | head --bytes=21)

if [[ "$track" == "" ]]; then
        text=""
    else
        text=$(echo "| 🎧$artist - $track |" | tr -s " ")
    fi

echo $text


