timezone=$(cat /run/user/1000/current-time-switch)

emoji="UA"

if [[ "$timezone" == "Europe/Kiev" ]]; then
    emoji="UA"
else
    emoji="CA"
fi

output=$(TZ="$timezone" date +"%A %d.%m.%y %H:%M:%S")
echo "$emoji | $output"
