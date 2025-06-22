#!/usr/bin/env bash

PIDFILE="/var/run/user/$UID/Activate-Linux.pid"

while read p; do
	[[ "$p" != "" ]] && kill -9 "$p";
done < $PIDFILE

if [ "$(date | grep "Apr  1")" != "" ]; then
	activate-linux --text-title "Activate Arch™" --text-message "Activate Arch™ btw." --overlay-width 200&
	echo $! > $PIDFILE
fi
