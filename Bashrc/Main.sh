#!/usr/bin/env bash
Seperate()
{
        Chars=( '\033[2;35m🭜🭘' '\033[0;35m🭣🭧' '\033[2;35m🭈🭆' '\033[0;35m🭑🬽' );

        for ((i=0; i < $(($1 * 2)); i++)); do
                Line=""
                for ((j=0; j < $(($(tput cols) -1)); j+=2)); do
                        Line="$Line${Chars[$(( (j / 2) % 2 + ((i + 1) % 2) * 2 ))]}"
                done

                echo -e "$Line"
        done

        echo -en '\033[0m'
}

Files=();

cd ~/Bashrc
for File in *; do
	if [ "$File" != "Main.sh" ]; then
		Files+=("$File")
	fi
done

Seperate 1
. ${Files[$(($RANDOM % ${#Files[@]}))]}
#.  ${Files[0]}
Seperate 1

cd ~
