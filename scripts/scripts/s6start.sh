killall -q s6-svscan
killall -q s6-supervise
killall -q s6-log
s6-svscanctl -t /run/user/1000/s6/scandir

ramdir="/run/user/$(id -u)"
rm -rf "$ramdir/s6"

s6dir="$HOME/.s6"
s6compdir="$s6dir/db/compiled"
s6sourcedir="$s6dir/source"

s6ramdir="$ramdir/s6"
s6scandir="$s6ramdir/scandir"
s6livedir="$s6ramdir/live"

mkdir -p "$s6scandir"
mkdir -p "$s6ramdir/log/everything"

s6-svscan "$s6scandir" 2>&1 | s6-log n3 s2000000 T "$s6ramdir/log/everything" &
s6-rc-init -c "$s6compdir" -l "$s6livedir" "$s6scandir"
s6-rc -l "$s6livedir" -u change default

