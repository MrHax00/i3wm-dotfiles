#!/usr/bin/env bash

Height=20;
LineOffset=7;

Length=$(tput cols)

Pad=$(($RANDOM % ($Length - 14)));
PadCol=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")
BallCol=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")

Bricks=()
BrickCols=()
BrickOffset=$(( (($Length + $LineOffset) % 14) / 2 ))

BallY=$(( $RANDOM % ($Height - 2) ))
BallX=$(($RANDOM % $Length))

for ((i = 0; i < $Height; i++)); do
	if (($i % 2 == 0)) && (( $i / 2 <= ($Height / 5) )); then
		Bricks=()
		Left=$Length
		At=0
		
		while (( $Left >= 14 + $LineOffset * 2)); do
			Bricks[At]=$(($RANDOM % 4 > 1))
			BrickCols[At]=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")
			
			BallDist=$(($At * 14 - $BallX))
			BallDistY=$(($i - $BallY))
			if (($BallDistY <= 1)) && (($BallDistY >= -1)) && (($BallDist <= 14 )) && (($BallDist >= -14)); then
				Bricks[At]=0	
			fi
			
			Left=$(($Left - 14))
			((At++))
		done
	fi
	
	if (( $i / 2 <= $Height / 5 )); then
		echo -n "$(perl -E "say \" \1\" x $BrickOffset")"
		
		if (( ($i / 2) % 2 == 1 )); then
			echo -n "$(perl -E "say \" \1\" x $LineOffset")"
		fi
		At=0
		for v in ${Bricks[*]}; do
			if [ "$v" == 0 ]; then
				if (($i == $BallY)) && (($At * 14 + 14 > $BallX)) && (($At * 14 < $BallX)); then
					echo -n "$(perl -E "say \" \1\" x $(( ($BallX % 14) - 1 ))")$BallCol🮮"
					echo -n "$(perl -E "say \" \1\" x $(( 14 - ($BallX % 14) ))")"
				else	
					echo -n "$(perl -E "say \" \1\" x 14")"
				fi
				((At++))
				continue
			fi
			
			if (( ($i % 2) == 0)); then
				echo -n "${BrickCols[$At]}╔════════════╗"
			else
				echo -n "${BrickCols[$At]}╚════════════╝"
			fi
			
			((At++))
		done
	fi
	
	if (($BallY == $i)) && (( $i / 2 > $Height / 5 )); then
		echo -n "$(perl -E "say \" \1\" x $(($BallX - 1))")$BallCol🮮"
	fi
	
	if (( $i == ($Height - 2) )); then
		echo -n "$(perl -E "say \" \1\" x $Pad")$PadCol╔════════════╗"
	elif (( $i == ($Height - 1) )); then
		echo -n "$(perl -E "say \" \1\" x $Pad")$PadCol╚════════════╝"
	fi
	echo
done
