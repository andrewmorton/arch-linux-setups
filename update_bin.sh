#!/bin/bash
####VARS
target_dir="ajm_bin"
GIT_REPO_DIR="$(dirname $0)/$target_dir"
LOCAL_AJM_DIR="/usr/local/bin/$target_dir"

####Functions

prompt_to_stderr () {
	msg=$1
	local response=""
	read -p >&2 "$msg" response
	echo $response
}

investigate_changes () {
	local git_repo_dir=$1
	local host_bin_dir=$2
	local investigate=$(prompt_to_stderr "To compare host bin with repo bin, enter the bin name here [blank skips this step]: ")
	while [[  $investigate != "" ]]
	do
		diff -u $git_repo_dir/$investigate $host_bin_dir/$investigate
		investigate=$(prompt_to_stderr "Enter another bin here to investigate differences [blank skips this]: ")
	done
}

clean_up_failed_push () {
	local msg="$1"

	>&2 echo "$msg"
	if [[ ! ( -e ~/failed_git_push) ]]
	then
		mkdir ~/failed_git_push
	fi
	sudo mv $(dirname $0)/ajm_bin ~/failed_git_push/ajm_bin.bak
	git checkout . 
}

git_worker () {
	local commit_msg=""
	local confirm_changes=""

	git stash &&
	git pull &&
	git stash pop &&
	git add . &&
	git status &&
	confirm_changes=$(prompt_to_stderr "Ok to commit these changes? [y/N]: ")
	if [[ $confirm_changes != "y" ]]
	then
		clean_up_failed_push "Git push exited by user. 1 backup will be saved in ~/failed_git_push"
		exit 1
	else
		commit_msg=$(prompt_to_stderr "Enter commit message for updating git repo: ")
		git commit -a -m "$commit_msg" &&
		git push &&
		>&2 echo "Git push completed successfully."
	fi
}

update_binaries () {
	local git_dir=$1
	local host_bin=$2
	local file_check=""
	local response=""

	>&2 echo "Update binaries of github repo?"
	response=$(prompt_to_stderr "Note this will directly copy current $host_bin from host. [y/N]: ")
	if [[ $response != "y" ]]
	then 
		>&2 echo  "$0 exited by user."
		exit 1
	else
		>&2 diff -qr $git_dir $host_bin
		investigate_changes $git_dir $host_bin 
		file_check=$(prompt_to_stderr "Do these files look correct? [y/N]: ")
		if [[ $file_check != "y" ]] 
		then
			>&2 echo "$0 exited by user."
		else
			sudo cp $host_bin/* $git_dir
			sudo chmod 777 $git_dir/*
			git_worker &&
				>&2 echo "$0 completed successfully, git repo has been updated."
		fi
	fi
			
}
####MAIN
update_binaries $GIT_REPO_DIR $LOCAL_AJM_DIR
