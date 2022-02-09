ping -c1 host.com >> /dev/null
success=$?
while true; do
    if [ $success -eq 1 ]; then
        echo Failure! Wifi reloaded!
        reloadwifi.sh
        sleep 1s
    fi
    sleep 2s
done
