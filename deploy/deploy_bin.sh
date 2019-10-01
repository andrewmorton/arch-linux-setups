#!/bin/bash
ajm_bin="ajm_bin"
script_dir="/home/tas/repos/local-linux-setups/"

deploy_repo () {
	local usr_bin="$1"

	ln -s $script_dir/$usr_bin/ /usr/local/bin/$usr_bin &&
	echo "export PATH=\$PATH:/usr/local/bin/ajm_bin" >> ~/.bashrc
	exit 0
}

cd $script_dir
deploy_repo $ajm_bin 
