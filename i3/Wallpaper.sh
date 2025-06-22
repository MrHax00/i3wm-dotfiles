#!/usr/bin/env bash

# from https://www.youtube.com/watch?v=b8rh9m3wOjk

PIDFILE="/var/run/user/$UID/bg.pid"

PIDs=()

while read p; do
	[[ "$p" != "" ]] && kill -9 "$p";
done < $PIDFILE

for Screen in $(xrandr -q | grep " connected " | grep -Po "\d+x\d+\+\d+\+\d+"); do
	xwinwrap -ov -ni -g "$Screen" -- mpv --fullscreen \
		--no-stop-screensaver \
		--vo=gpu --hwdec=vdpau \
		--loop-file --no-audio --no-osc --no-osd-bar -wid WID --no-input-default-bindings \
		--speed=.6 "$1" &
	PID=$!
	PIDs+=($PID)
	xdotool search --sync --all --pid ${PID} --name '.*' set_window --classname "wallpaper" set_window --class "wallpaper"&
done

printf "%s\n" "${PIDs[@]}" > $PIDFILE
