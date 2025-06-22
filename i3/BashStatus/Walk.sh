#!usr/bin/env bash

if [ "$LastReminder" == "" ]; then
	LastReminder="$(date +%s)"
	ShowWalkTime=1;
	WalkPaused=0;
	WalkAlarm=0;
fi

if [ "$WalkPaused" == "1" ]; then
	LastReminder=$(($(date +%s) - $WalkPauseDelta))
fi

TimePassed="$(echo $LastReminder $(date +%s) | awk '{ print int(($2 - $1) / 60) }')"

WalkTextMin=""

if [ "$TimePassed" == "50" ]; then
	LastReminder=$(date +%s)
	WalkText="0m"
	WalkEmoji="🪑"
	WalkAlarm=0
elif [ "$TimePassed" -ge "45" ]; then
	WalkText="$((50 - $TimePassed))m"
	WalkEmoji="🏃"
	if [ "$WalkAlarm" == "0" ]; then
		WalkAlarm=1
		nohup play "~/.config/i3/BashStatus/.config/WalkAlarm.wav"&
	fi
else
	WalkText="${TimePassed}m"
	WalkEmoji="🪑"
fi

if [ "$ShowWalkTime" == "1" ]; then
	WalkText="$WalkEmoji $WalkText"
	WalkTextMin="W 00m W"
else
	WalkText="$WalkEmoji"
	WalkTextMin="W W"
fi

if [ "$WalkPaused" == "1" ]; then
	WalkText="$WalkText "
else
	WalkText="$WalkText "
fi

WalkReminder.Click()
{
	if [ "$(echo $1 | jq -r ".modifiers[0]")" == "Shift" ] && [ "$(echo $1 | jq -r ".modifiers[1]")" == "Control" ]; then
		#LastReminder=$(($(date +%s) - 60 * 44 - 50))
		LastReminder=$(date +%s)
		WalkPauseDelta="0"
	elif [ "$(echo $1 | jq -r ".modifiers[0]")" == "Shift" ]; then
		ShowWalkTime=$((1 - $ShowWalkTime))
	elif [ "$(echo $1 | jq -r ".modifiers[0]")" == "Control" ]; then
		WalkPaused=$((1 - $WalkPaused))
		WalkPauseDelta=$(($(date +%s) - $LastReminder))
	fi
}

StartBlock
	StrProp name WalkReminder
	StrProp full_text "$WalkText"
	StrProp min_width "$WalkTextMin"
EndBlock
