#!/bin/sh

s6_treedir="$HOME/.hypr/s6-usertree"

s6_compdir="$s6_treedir/rc/compiled" # compiled database directory
s6_dir="$XDG_RUNTIME_DIR/s6" # s6 data folder (scandir, livedir, logs, etc)
s6_scandir="$s6_dir/service" # s6 scandir
s6_livedir="$s6_dir/s6-rc" # s6-rc livedir
s6_logger_fifo="$s6_scandir/s6-svscan-log/fifo" # fifo where all uncaught messages will go

s6-svscanctl -t $s6_dir/scandir

mkdir -p "$s6_scandir"
mkdir -p "$s6_dir/log"
cp -rL "$s6_treedir/s6-svscan-log" "$s6_scandir"
mkfifo "$s6_logger_fifo"

setsid -f \
    redirfd -wnb 1 "$s6_logger_fifo" \
    fdmove -c 2 1 \
    envfile $s6_treedir/config/env.conf \
    s6-svscan -d 4 "$s6_scandir" 4>&1 | read

s6-rc-init -c "$s6_compdir" -l "$s6_livedir" "$s6_scandir"
s6-rc -l "$s6_livedir" -u change default