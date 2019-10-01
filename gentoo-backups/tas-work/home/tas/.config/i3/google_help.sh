#!/bin/bash
#Displays a list of websites that the google chrome shortcuts are mapped to.

readarray file_array < ${HOME}/.config/i3/google_help_array.txt
msg=""


for website in "${!file_array[@]}"
do
	declare -a element=(${file_array[website]})
	msg+="${element[0]}  =>  ${element[1]}\n"
done

notify-send -a "I3-Help" -u "low" "Current Webpages: " "$msg"
