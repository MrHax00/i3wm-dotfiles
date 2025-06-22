#!/usr/bin/env bash

Volume=$(amixer sget Master | grep "Left:" | grep -Po "\d+%" | grep -Po "\d+")

Output="  "
if [ "$Volume" = "0" ]; then
	Output="  "
elif [ "$Volume" -le "50" ]; then
	Output="  "
fi

VolumeSlider="▁▂▃▄▅▆▇█"

if [ "$VolumeFocused" = "1" ]; then
	StartBlock
		StrProp name VolumeCollapse
		StrProp full_text " > "
		Prop separator false
	EndBlock
	StartBlock
		StrProp name VolumeDisplay
		StrProp full_text "${VolumeSlider:0:$Volume*8/100+1}"
		StrProp min_width $VolumeSlider
	EndBlock
else
	StartBlock
		StrProp name VolumeToggle
		StrProp full_text $Output
		StrProp align center
		Prop separator_block_width 20
		Prop min_width 35
	EndBlock
fi

VolumeToggle.Click()
{
	if [ "$(echo $1 | jq -r ".modifiers[0]")" == "Shift" ]; then
		VolumeFocused=1
	else
		rofi -show volume -config ~/.config/rofi/volume.rasi &> /dev/null
	fi
}

VolumeCollapse.Click()
{
	VolumeFocused=0
}

VolumeDisplay.Click()
{
	Width=$(echo $1 | jq -r ".width")
	Target=$(echo $1 | jq -r ".relative_x" | awk "{ print \$1 / $Width * 100}")

	amixer -D pulse sset Master "$Target%" > /dev/null
}
