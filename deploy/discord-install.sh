#!/bin/bash
#Variables
discord_url="https://discordapp.com/api/download?platform=linux&format=tar.gz"
temp="/tmp"
discord_package="discord_install.tar.gz"
local_bin="${HOME}/bin"
desktop_file="Discord/discord.desktop"

echo "installing Discord"
wget -O  $temp/$discord_package "$discord_url"
tar -C $local_bin/ -xvzf $temp/$discord_package
chmod 777 $local_bin/Discord/Discord
ln -s $local_bin/Discord/Discord $local_bin/discord
mv $local_bin/$desktop_file /usr/share/applications/

#check to make sure that libatomic is installed as a dependency
if [[ $(type libatomic) ]]
then
	echo "All set"
else
	echo >&2 "Requesting permission to install dependencies"
	sudo emerge --ask --tree --verbose libatomic
fi
