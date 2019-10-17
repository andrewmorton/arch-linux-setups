#!/bin/bash

function adjust_input () {
	input_string="$@"
	search_term=$( echo ${input_string} | sed -e 's/\s\+/\+/g' )
	echo ${search_term}
}


search_term=$( adjust_input "$@" )

google-chrome-stable --force-device-scale-factor=1.25 www.google.com/search?q=${search_term}



