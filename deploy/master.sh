#!/usr/bin/sudo bash
#Vars
script_dir=$(dirname $(realpath "$0"))
chrome_install="./chrome-install.sh"
discord_install="./discord-install.sh"
deploy_bin="./deploy_bin.sh"
golang_install="./golang-setup"
python_install="./python-install.sh"
snapd_install="./snapd-install.sh"
vscode_install="./vscode-install.sh"
bash_tools_install="./bash-tools-install.sh"

run_script () {
	local target="$1"
	echo "Running $target..."
	bash -c "$target" -
}


echo "Starting build of System"
#update all packages
dnf update
cd $script_dir
run_script $deploy_bin
run_script $golang_install
run_script $python_install
run_script $vscode_install
run_script $chrome_install
run_script $bash_tools_install
run_script $snapd_install
echo "Updating .bashrc with rb alias"
echo 'export rb="exec bash"' >> ~/.bashrc
echo "Rebooting..."
sleep 5s
reboot

