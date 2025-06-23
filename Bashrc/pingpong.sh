#!/usr/bin/env bash

Height=20;

Length=$(tput cols)

PadA=$(($RANDOM % ($Height - 4)))
PadB=$(($RANDOM % ($Height - 4)))

BallX=$(($RANDOM % ($Length - 7) + 3))
BallY=$(($RANDOM % $Height))

ColA=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")
ColB=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")
ColC=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")

for ((i = 0; i < $Height; i++)); do
	DistA=$(($i - $PadA))
	DistB=$(($i - $PadB))
	
	Remaining=$Length
	
	if [ "$DistA" == 0 ]; then
		echo -n "$ColA ╔╗"
		Remaining=$(($Remaining - 3));
	elif [ "$DistA" -gt 0 ] && [ "$DistA" -lt 4 ]; then
		echo -n "$ColA ║║"
		Remaining=$(($Remaining - 3));
	elif [ "$DistA" == 4 ]; then
		echo -n "$ColA ╚╝"
		Remaining=$(($Remaining - 3));
	fi
	
	if [ "$BallY" == "$i" ]; then
		echo -n "$(perl -E "say \" \1\" x $(($BallX - ($Length - $Remaining)))")$ColC🮮 "
		Remaining=$(($Length - $BallX - 2))
	fi
		
	if [ "$DistB" == 0 ]; then
		Remaining=$(($Remaining - 3));
		echo -n "$(perl -E "say \" \1\" x $Remaining")$ColB╔╗"
	elif [ "$DistB" -gt 0 ] && [ "$DistB" -lt 4 ]; then
		Remaining=$(($Remaining - 3));
		echo -n "$(perl -E "say \" \1\" x $Remaining")$ColB║║"
	elif [ "$DistB" == 4 ]; then
		Remaining=$(($Remaining - 3));
		echo -n "$(perl -E "say \" \1\" x $Remaining")$ColB╚╝"
	fi
	
	echo	
done
