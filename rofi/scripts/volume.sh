#!/usr/bin/env bash

#if [ $ROFI_RETV == 1 ]; then
#if [ "$ROFI_INFO" == "0" ]; then
#	exit
#fi

AddControls()
{
	Name="$1"
	Loudness="$2"
	for ((i = 5; i > 0; i--)); do
		Volume=$(echo $Loudness | awk '{ print $1 * 5 / 100 }');
		
		if awk "BEGIN {exit !($i <= $Volume)}"; then
			echo -e " \0info\x1f$Name:$i\x1ficon\x1f~/.config/rofi/Assets/Volume.png"
		else
			echo -e  " \0info\x1f$Name:$i"
		fi
	done
}

SelectedName()
{
	echo $ROFI_INFO | cut -d ":" -f 1
}

SelectedVolume()
{
	echo $ROFI_INFO | cut -d ":" -f 2 | awk '{ print $1 / 5 * 65385}'
}

#
# Handle master getting set
#

if [ "$(SelectedName)" = "0" ] && [ $ROFI_RETV == 1 ]; then
	pactl set-sink-volume @DEFAULT_SINK@ "$(SelectedVolume)" > /dev/null
fi

Volume=$(amixer sget Master | grep "Left:" | grep -Po "\d+%" | grep -Po "\d+")

Output="audio-volume-high"
if [ "$Volume" = "0" ]; then
	Output="audio-volume-muted"
elif [ "$Volume" -le "33" ]; then
	Output="audio-volume-low"
elif [ "$Volume" -le "80" ]; then
	Output="audio-volume-medium"
fi

AddControls 0 $Volume
echo -e "Master\0icon\x1f$Output\x1finfo\x1f0:0"

PactlData="$(pactl list sink-inputs)"
RecordIndex=1
while (( 1 )); do
	# pactl seems to seperate sink inputs by putting an empty line between them hence RS="" (i had a breakdown figuring this nonsense out please help me get therapy)
	Record="$(echo "$PactlData" | awk -v RS="" "FNR == $RecordIndex {print \$0}")"
	if [ "$Record" = "" ]; then
		break
	fi

	SinkID=$(echo "$Record" | grep -P "Sink Input #\d+|^\d+" | grep -Po "\d+")
	AppName=$(echo "$Record" | grep -P "application\.name = \".+\"" | cut -d '"' -f 2)
	MediaName=$(echo "$Record" | grep -P "media\.name = \".+\"" | cut -d '"' -f 2)
	Volume=$(echo "$Record" | grep "Volume: front-left: " | cut -d "/" -f 2 | grep -Po "\d+")

	PID=$(echo "$Record" | grep -P "application\.process\.id = \".+\"" | cut -d '"' -f 2)

	if [ "$(SelectedName)" = "$SinkID" ]; then
		pactl set-sink-input-volume $SinkID $(SelectedVolume)
		Volume=$(echo $ROFI_INFO | cut -d ":" -f 2 | awk '{print $1 * 20}')
	fi

	while read -r WindowID; do
		# from https://superuser.com/questions/1017454
		xprop -id $WindowID -notype 32c _NET_WM_ICON |
		perl -0777 -pe '@_=/\d+/g;
		printf "P7\nWIDTH %d\nHEIGHT %d\nDEPTH 4\nMAXVAL 255\nTUPLTYPE RGB_ALPHA\nENDHDR\n", splice@_,0,2;
		$_=pack "N*", @_;
		s/(.)(...)/$2$1/gs' | pamrgbatopng > "/tmp/$AppName.png"
		if (( $? == 0 )); then
			break
		fi
	done <<< "$(xdotool search --pid $PID)" &> /dev/null

	#echo "|$SinkID| |$Volume|"	
	AddControls $SinkID $Volume
	echo -e "$AppName:$MediaName\0icon\x1f/tmp/$AppName.png\x1finfo\x1f$SinkID:Mute"

	((RecordIndex++))
done
