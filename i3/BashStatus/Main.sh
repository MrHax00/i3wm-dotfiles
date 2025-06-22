#!/usr/bin/env bash
cd $(echo $0 | grep -Po ".+/")

echo '{ "version": 1, "click_events":true }'

echo '['

echo '[]'

SeperateProp=0
StrProp()
{
	if [ "$SeperateProp" = "0" ]; then
		echo -n ""
	else
		echo -n ","
	fi
	SeperateProp=1
	echo -n "\"$1\":\"$2\""
}

Prop()
{
	if [ "$SeperateProp" = "0" ]; then
		echo -n ""
	else
		echo -n ","
	fi
	SeperateProp=1
	echo -n "\"$1\":$2"
}

SeperateBlock=0
StartBlock()
{
	if [ "$SeperateBlock" = "0" ]; then
		echo -n ""
	else
		echo -n ","
	fi
	SeperateBlock=1
	SeperateProp=0

	echo -n "{"
}

EndBlock()
{
	echo -n "}"
}

Missing=0
[ "${#@}" = 0 ]&&Missing=1

for v in "$@"; do
	if [ ! -f "$v.sh" ] || [ "$v" = "Main" ]; then
		Missing=1
		break
	fi
done

while [ "$Missing" = "1" ]; do
	echo -n ",["
	
	StartBlock
		StrProp name error
		StrProp full_text "Too few or invalid arguments. "
		StrProp color "#ff0000"
	EndBlock

	echo "]"
	SeperateBlock=0
	sleep 1
done

while :; do

	echo -n ",["
	
	for Block in "$@"; do
		. "$Block.sh"
	done

	echo "]"
	SeperateBlock=0

	while read -sr -t 0.1 line; do 
		Data=$(echo $line | grep -Po "{.+")
		Name=$(echo $Data | jq -r ".name")
		
		echo $Data > ~/Test.test
		$Name.Click "$Data" &> /dev/null
	done
	sleep 0.1
done
