#!/usr/bin/env bash

Height=20;
SpacingH=5;
SpacingV=1;

Length=$(tput cols)

WhiteSpace="$(perl -E "say \" \1\" x 2")"

Pad=$(($RANDOM % ($Length - 11)));
PadCol=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")

Width=( 4 6 6 8 )
Index=( 0 16 40 64 )

Bullets=( "🬗" "🬤" )

BulletSpace()
{
	if (($RANDOM % 300 == 0)); then
		echo -n "${Bullets[$(($RANDOM % 2))]}"
	else
		echo -n $WhiteSpace
	fi
}

Aliens=( "$WhiteSpace" "▟" "▙" "$WhiteSpace" )
Aliens+=( "▟" "▜" "▛" "▙" )
Aliens+=( "▀" "▛" "▜" "▀" )
Aliens+=( "▞" "▞" "▚" "▚" )

Aliens+=( "▖" "▚" "$WhiteSpace" "$WhiteSpace" "▞" "▗" )
Aliens+=( "▙" "▛" "█" "█" "▜" "▟" )
Aliens+=( "▜" "█" "█" "█" "█" "▛" )
Aliens+=( "▗" "▘" "$WhiteSpace" "$WhiteSpace" "▝" "▖" )

Aliens+=( "▗" "▄" "█" "█" "▄" "▖" )
Aliens+=( "█" "▛" "▜" "▛" "▜" "█" )
Aliens+=( "▀" "▜" "▛" "▜" "▛" "▀" )
Aliens+=( "▄" "▀" "▝" "▘" "▀" "▄" )

Aliens+=( "$WhiteSpace" "▗" "▟" "█" "█" "▙" "▖" "$WhiteSpace" )
Aliens+=( "▗" "▛" "█" "▜" "▛" "█" "▜" "▖" )
Aliens+=( "▀" "█" "▛" "▜" "▛" "▜" "█" "▀" )
Aliens+=( "$WhiteSpace" "▝" "$WhiteSpace" "$WhiteSpace" "$WhiteSpace" "$WhiteSpace" "▘" "$WhiteSpace" )

IsAlive=()
Type=0
Col=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")

for ((i = 0; i < $Height; i++)); do
	if (($i < (4 + $SpacingV) * 3 )); then
		if (($i % (4 + $SpacingV) == 0)); then
			Type=$(($RANDOM % 3))
			IsAlive=()
			Col=$(printf "\033[$(($RANDOM % 2));$(($RANDOM % 7 + 31))m")
		
			if [ $i == 0 ]; then
				Type=3
				Count=$(($Length / (${Width[2]} + $SpacingH)))
				for ((_i = 0; _i < $Count; _i++ )); do
					IsAlive[_i]=0
				done
				
				IsAlive[$(($RANDOM % $Count))]=1
				Col=$(printf "\033[1;31m")
			fi
		fi
		
		if (( $i % (4 + $SpacingV) >= 4 )); then
			echo
			continue
		fi
		SpriteWidth=${Width[$Type]}
		SpriteIndex=${Index[$Type]}
		
		SpaceAmount=$(( ($Length % ($SpacingH + $SpriteWidth)) / 2 + $SpacingH / 2 + 1 ))
		
		echo -n "$Col$(perl -E "say \" \1\" x $(($SpaceAmount))")"
		for ((j = 0; j < $Length - $SpaceAmount - 1; j++)); do
			Alive=${IsAlive[$(( $j / ($SpriteWidth + $SpacingH) ))]}
			if [ "$Alive" == "" ]; then
				Alive=$(($RANDOM % 3 <= 2 - $i / (4 + $SpacingV)))
				IsAlive[$(( $j / ($SpriteWidth + $SpacingH) ))]="$Alive"
			fi
			
			if (($j % ($SpacingH + $SpriteWidth) < $SpriteWidth )) && (($Alive == 1)); then
				echo -n ${Aliens[$(( $SpriteIndex + ($i % (4 + $SpacingV)) * $SpriteWidth + j % ($SpriteWidth + $SpacingH) ))]}
			else
				BulletSpace
			fi
		done
	elif (( $i < ($Height - 4) )); then
		for ((j = 0; j < $Length; j++)); do
			BulletSpace
		done
	elif (( $i == ($Height - 3) )); then
		echo -n "$(perl -E "say \" \1\" x $(($Pad + 4))")$PadCol╔═╗"
	elif (( $i == ($Height - 2) )); then
		echo -n "$(perl -E "say \" \1\" x $Pad")$PadCol╔═══╝ ╚═══╗"
	elif (( $i == ($Height - 1) )); then
		echo -n "$(perl -E "say \" \1\" x $Pad")$PadCol╚═════════╝"
	fi
	
	echo
done
