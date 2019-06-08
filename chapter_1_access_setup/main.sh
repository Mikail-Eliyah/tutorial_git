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
		block_function_from_proceding;
		generate_key;		
    elif [ "$main_menu_input" = "2" ]; then
		block_function_from_proceding;
		set_git_user_profile;	
    elif [ "$main_menu_input" = "3" ]; then
		test_git_connection;
    elif [ "$main_menu_input" = "4" ]; then
		check_git_updates;
    elif [ "$main_menu_input" = "5" ]; then
		instruction_for_users;	
    elif [ "$main_menu_input" = "6" ];then	
		check_git_version;				
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
