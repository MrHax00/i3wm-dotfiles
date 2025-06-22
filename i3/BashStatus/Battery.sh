#!/usr/bin/env bash

Charge=$(upower -i $(upower -e | grep "BAT") | grep "percentage:" | grep -Po "\d+")
State=$(upower -i $(upower -e | grep "BAT") | grep "state:" | awk '{ print $2 }')

Levels=(      )

if [ "$ChargeOffset" = "" ] || [ "$State" = "discharging" ]; then
	ChargeOffset=0;
fi

Output="  "
if [ "$Charge" -le "20" ]; then
	Output=" ${Levels[0 + $ChargeOffset]} "
	ChargeOffset=$(echo $ChargeOffset | awk '{ print ($1 + 1) % 5 }')
elif [ "$Charge" -le "40" ]; then
	Output=" ${Levels[1 + $ChargeOffset]} "
	ChargeOffset=$(echo $ChargeOffset | awk '{ print ($1 + 1) % 4 }')
elif [ "$Charge" -le "60" ]; then
	Output=" ${Levels[2 + $ChargeOffset]} "
	ChargeOffset=$(echo $ChargeOffset | awk '{ print ($1 + 1) % 3 }')
elif [ "$Charge" -le "80" ]; then
	Output=" ${Levels[3 + $ChargeOffset]} "
	ChargeOffset=$(echo $ChargeOffset | awk '{ print ($1 + 1) % 2 }')
fi

if [ "$BatteryFocused" = "" ]; then
	BatteryFocused=0
fi

if [ "$BatteryFocused" = "0" ]; then
	StartBlock
		StrProp name BatteryDisplay
		StrProp full_text "$Output"
		Prop min_width 25
	EndBlock
elif [ "$BatteryFocused" = "1" ]; then
	StartBlock
		StrProp name BatteryDisplay
		StrProp full_text "$Output$Charge%"
	EndBlock
fi

BatteryDisplay.Click()
{
	if [ "$(echo $1 | jq -r ".modifiers[0]")" == "Shift" ]; then
		BatteryFocused=$(echo $BatteryFocused | awk '{ print 1 - $1 }')
	fi
}
