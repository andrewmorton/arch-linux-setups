#!/bin/bash

declare -a conf_files=( "/etc/portage/package.use/zz-autounmask" 
			"/etc/portage/make.conf"
			"/etc/fstab" ) 

function copy_all () {
local backup_dir="$HOME/conf-backup"
local filename=""
	for file in "${conf_files[@]}" 
	do
		filename="$(basename $file).bak"

		if [[ -e $backup_dir/"$filename" ]] && [[ $backup_dir/"$filename" -nt $backup_dir/"$filename.2" ]]
		then 
			filename="$filename.2"
		fi

		cp $file $backup_dir/"$filename"
	done
}

copy_all
