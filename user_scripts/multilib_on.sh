#!/bin/bash

# If the pacman.conf file exists, echo the needed lines for multilib to the file

if [ -f /etc/pacman.conf ]
then
	echo "
	[multilib]
	Include = /etc/pacman.d/mirrorlist
	" >> /etc/pacman.conf
else
	echo "pacman.conf doesn't exist in /etc."
	echo "create the pacman.conf file first and then re-run this script"
	exit 1
fi
