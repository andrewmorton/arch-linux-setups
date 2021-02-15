#!/bin/bash

## Don't do anything but exit successfully if glow already found
if command -v "glow" 
then
	echo "glow already found based on command -v"
	echo "glow already installed"
	echo "moving on"
	exit 0
fi

## Means glow wasn't found, so we need to test for directories if the
## process was interrupted or install fresh
if ! command -v "git" || ! command -v "go" &>> /dev/null
then
	echo "Dependencies not found"
	echo "markdown.sh requires both git and go to be installed and in path."
	exit 1
elif [ -d /tmp/glow ]
then
	echo "/tmp/glow already found. Don't need to clone"
	echo "Moving on to build and install"
else
	git clone https://github.com/charmbracelet/glow.git /tmp/glow
fi

## Test if we have $HOME/bin as a directory and build if we do
if [ -d $HOME/bin ]
then
	cd /tmp/glow
	echo "Building glow from /tmp/glow"
	go build && cp /tmp/glow/glow $HOME/bin
	echo "Build and install of glow complete"
	echo "Run with glow <markdown file> from a cli"
	exit 0
fi

