#!/bin/sh
# version: 2019-06-07_1157hr_23sec

# include configuration file (containing variables)
dos2unix "./config_profile.sh"
source "./config_profile.sh"

# dos2unix "./scripts/cipher_utility.sh"
# source "./scripts/cipher_utility.sh" # 

function print_menu() {
	echo "Press 1 : generate_key"
	echo "Press 2 : set_git_user_profile"
	echo "Press 3 : test_git_connection"
	echo "Press 4 : check_git_updates"
	echo "Press 5 : instruction_for_users"	
    echo "Press 6 : check_git_version"	
	
	echo "Press 'x' or 'X' to exit the script"
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

function check_git_updates(){
	echo 'Checking for updates at: '$git_target
	git clone $git_target
	git log
	ls
	git status -s
}

function block_function_from_proceding(){
	echo "This function is prohibited for now."
	exit;
	echo 'If you are seeing this line. The exit() is not working.'
}

function set_git_user_profile() {
	user_id=id_git
	git config --global --unset-all user.name
	git config --global user.name $id_git
	git config --global user.email $email_address
	# git config --global --replace-all user.name $id_git	
	#git config --global core.editor vim
	#git config --global merge.tool vimdiff # Set default merge tool. Git does not provide a default merge tool for integrating conflicting changes into working tree
	
	# enable color highlighting for Git in console.
	git config --global color.ui true
	git config --global color.status auto
	git config --global color.branch auto
	git config --list
	
	# start ssh-agent in the background 
	eval $(ssh-agent -s) # eval "$(ssh-agent -s)"
	ssh-add $key_store$key_id # add private key, i.e. $private_authentication_key_with_path

	echo "set_git_user_profile done."
	git config --list # list Git settings
	# git config --global core.editor vim # default editor
	# git config --global merge.tool vimdiff # default merge tool
	# 
	
	echo $demarcator
	ssh -T git@gitlab.com	# try connecting to git account
}

function test_git_connection () {
	echo "Activating ssh-agent ..."
	# test log in
	# ls -al ~/.ssh # check for existing ssh on machine
	ls -al $key_store
	# clip < ~/.ssh/id_rsa.pub # ***.pub
	activate_ssh_agent_for_git;

	ssh -T git@github.com 
	# cat log.txt | grep --color=auto "successfully authenticated" 
	#ssh -vT git@github.com
	
	echo "If not successfully authenticated, please refer to: [url to be stated]" 
	echo "Closing ssh-agent ..."
	ps_id=$(ps -ef | grep "ssh-agent" | awk  '{print $2}') # 
	kill -9 $ps_id	
	#ps_id=$(ps -ef | grep "ssh-agent" | awk  '{print $3}') # $3 is the 3rd text token
	#kill -9 $ps_id
	
	# clean_all_ssh_agent_processes;
}

function activate_ssh_agent_for_git(){
	echo "Activating ssh-agent ..."
	echo $demarcator
	eval $(ssh-agent -s)

	ssh-add $key_store$key_id # ssh-add ~/.ssh/id_rsa # add private # ssh-add ~/.ssh/***.private
	ssh-add -l
	# $ ssh-add -l -E sha256
	# $ ssh-add -l -E md5 # check for key
	
	echo "ssh-agent is up ..."
	# ps -ef
}

function generate_key () {
	#ssh_keys_dir='./.ssh/' #mkdir $ssh_keys_dir
	echo "Generate Public/Private RSA Key Pair for Git user authentication"
	echo "Just enter, when prompt later, but enter key name now:"
	#read key_id
	
	echo 'Generating new key (and to be saved as key ID: '$key_store$key_id' )'

	ssh-keygen -t rsa -b $key_rsa_length -C $email_address
	
	#cp '../.ssh/id_rsa.pub' $key_store$key_id'_rsa.pub'
	#cp '../.ssh/id_rsa' $key_store$key_id'_rsa'
	#rm -rf '../.ssh/id_rsa' '../.ssh/id_rsa.pub'
	#rm -rf $ssh_keys_dir
	
	echo "generate_key done"
	# ssh-copy-id -i $key_rsa_authentication_public $git_remote
	echo 'New git key (key ID: '$key_store$key_id' ) generated.'
	echo $demarcator
	cat  $key_store$key_id'.pub'
	echo $demarcator
	echo 'Add this public key to github a/c'
}


function clean_all_ssh_agent_processes () {
	process_name='ssh-agent'
	echo 'removing ID: '
	echo $(ps aux | grep -e 'ssh-agent' | awk '{ print $1 }')
	kill -9 $(ps aux | grep -e 'ssh-agent' | awk '{ print $1 }')
	
	ps -ef
}

function check_git_version() {
	time_stamp=$(date +"%Y-%m-%d_%H%Mhr_%S"sec)
	echo "Now: " $time_stamp 
	git --version
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