#!/usr/bin/bash
selected=`xclip -o -selection-pri`
sourcelang=`trans -b -identify "$selected"`
if [ "$sourcelang" = "ru" ]; then
  direction="$sourcelang -> en"
  translated=`trans -b :en "$selected"`
else
  direction="$sourcelang -> ru"
  translated=`trans -b :ru "$selected"`
fi
#notify-send --hint int:transient:1 "Google Translate $direction" "$translated"
#zenity --title=Перевод --info --text="$translated" --width=350
zenity --entry --text="Google Translate $direction\n$selected" --entry-text="$translated"
