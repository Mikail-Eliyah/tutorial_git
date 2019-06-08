#!/bin/sh
# version: 2019-06-07_1157hr_23sec

# include configuration file (containing variables)
dos2unix "./config_profile.sh"
source "./config_profile.sh"

# dos2unix "./scripts/cipher_utility.sh"
# source "./scripts/cipher_utility.sh" # 

function print_menu() {
	echo "Press 1 : set_up_repo_folder"
	echo "Press 2 : repo_get"
	echo "Press 3 : ensure_connection_before_updates"
	echo "Press 4 : repo_update_all_files_and_push_to_remote"
	echo "Press 5 : instruction_for_users"	
	
	echo "Press 'x' or 'X' to exit the script"
}

function ensure_connection_before_updates(){
	ssh-add $key_store$key_id # add private key reference for ssh-agent
	
	echo "Registered git repo to be pushed onto:"	
	git remote -v
	
	eval "$(ssh-agent -s)"
	
	git status	# check status when connection is ready for git push
}

function repo_get(){
	git init	# git initialize the folder
	
	echo 'Checking for updates at: '$git_target
	git clone $git_target
	git log
	git status -s
	
	ls
}

function repo_update_all_files_and_push_to_remote(){
	git add .
	git status
	
	echo "Enter comments:"
	read message_comments
	
	git commit -a -m $message_comments
	git push -u origin master
}

function set_up_repo_folder () {
	echo "Create local repo (match remote repo name preferred):"
	read repo_name
	
	if [ -f "$repo_name" ]; then
		echo "$repo_name exist"
	else 
		mkdir $repo_name; 
		echo "Do: cd " $repo_name
		
		echo $demarcator
		echo $repo_name" created."
	fi
	
}

function instruction_for_users(){
	echo "
	=================== INSTRUCTION START ===================
	[Caveat]: For reference purposes only.
	
	[Notes]:
	1. block_function_from_proceding() is a function to disable function. Comment it to deactivate / unblock it.
	2. Do update config_profile.sh to ensure you have all the supporting parameters.
	
	=================== INSTRUCTION END ===================
	"
}

function block_function_from_proceding(){
	echo "This function is prohibited for now."
	exit;
	echo 'If you are seeing this line. The exit() is not working.'
}

function exit_program() {
	printf "\n quit.\n"
	echo 'X' : quitprogram
}

function default_action() {
    echo "You have entered an invallid selection!"
    echo "Please try again!"
    echo ""
    echo "Press any key to continue..."
    read -n 1
    clear
	set -u # force it to treat unset variables as an error 
	unset mainmenuinput
	#echo $mainmenuinput 
    main
}