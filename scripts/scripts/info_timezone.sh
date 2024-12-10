#!/bin/sh

echo $$ >> /tmp/info_timezone.pid

FORMAT="%a | %d.%m.%Y %X"

set -- "Canada/Eastern" "Europe/Kyiv"

TIMEZONES_LENGTH=$#
current_idx=1

print_date() {
  TZ=${current_timezone:?} date +"${FORMAT}" | echo "$(cat -)"
}

update_current_timezone() {
  current_idx=$(($((current_idx+1)) % $(("$TIMEZONES_LENGTH"+1))))
  if [ $current_idx -lt 1 ]; then
    current_idx=1
  fi
}

click() {
  update_current_timezone
  print_date
}

trap "click" USR1

while true; do
  eval "current_timezone=\${$current_idx}"
  print_date current_timezone
  sleep 0.9 &
  wait
done
