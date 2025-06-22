#!/usr/bin/env bash

PowerMode=$(cat /sys/devices/platform/asus-nb-wmi/fan_boost_mode)
[[ "$PowerMode" == "" ]] && PowerMode=$(cat /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy)

case $PowerMode in
	0)
		StartBlock
			StrProp name PowerMode
			StrProp full_text " Mode: ⚖"
			StrProp min_width " Mode: 🔥"
		EndBlock
	;;
	
	1)
		StartBlock
			StrProp name PowerMode
			StrProp full_text " Mode: 🔥"
			StrProp min_width " Mode: 🔥"
		EndBlock
	;;
	
	2)
		StartBlock
			StrProp name PowerMode
			StrProp full_text " Mode: 🍃"
			StrProp min_width " Mode: 🔥"
		EndBlock
	;;

	*)
		StartBlock
			StrProp name PowerMode
			StrProp full_text " Mode: ❓"
			StrProp min_width " Mode: 🔥"
		EndBlock
	;;
esac
