#!/bin/sh
# version: 2019-06-07_1157hr_23sec
dos2unix "./main_functions.sh"
source "./main_functions.sh"

# supporting

# MAIN
main () {
	print_menu;
	number_of_digits_for_inputs=2
	# read  -n 1 -p "Input Selection:" main_menu_input
	read  -n $number_of_digits_for_inputs -p "Input Selection:" main_menu_input
	echo ""
	
	if [ "$main_menu_input" = "1" ]; then
		set_up_repo_folder;	
    elif [ "$main_menu_input" = "2" ]; then
		repo_get;	
    elif [ "$main_menu_input" = "3" ]; then
		ensure_connection_before_updates;
    elif [ "$main_menu_input" = "4" ]; then
		repo_update_all_files_and_push_to_remote;
    elif [ "$main_menu_input" = "5" ]; then
		instruction_for_users;				
    elif [ "$main_menu_input" = "x" -o "$main_menu_input" = "X" ];then # -o := `or` and `||`
		exit_program;
    else
		default_action;
    fi
}

# This builds the main menu and routs the user to the function selected.
main # This executes the main menu function.

echo ""
: <<'COMMENT_GENERATE_PASS'


COMMENT_GENERATE_PASS
echo ""
