rm -rf ~/.s6/db/compiled

#export timestamp=$(date +%s)

s6-rc-compile ~/.s6/db/compiled ~/.s6/source
#ln -s ~/.s6/db/compiled-$timestamp ~/.s6/db/compiled
