#!/usr/bin/env bash
LockPic=~/.config/i3/ScarletTree.png

X=$(i3-msg -t get_workspaces | jq '.[] | select(.visible==true).rect.x')
X=(${X//$'\n'/ })

Y=$(i3-msg -t get_workspaces | jq '.[] | select(.visible==true).rect.y')
Y=(${Y//$'\n'/ })

PIDs=()

for ((i = 0 ; i < ${#X[@]}; i++ )); do
	WindowName="feh-lockBg:$i"

	feh -x $LockPic&
	PIDs[$i]=$!
	
	xdotool search --sync --all --pid ${PIDs[$i]} --name '.*' \
	set_window --classname "feh-lockBg" --class "feh-lockBg" --name $WindowName
	
	Window=$(wmctrl -l | grep $WindowName | grep -Po "^\S+")
	wmctrl -ir $Window -e 0,${X[i]},${Y[i]},-1,-1
done

i3lock  -c 000000 -n

for i in "${PIDs[@]}"; do
	sleep .2
	kill -KILL $i
done
