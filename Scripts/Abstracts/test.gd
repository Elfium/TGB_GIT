class_name Test extends Node
##


##
signal tests_completed


##
func print_check(text : String) -> void : 
	print_rich("[color=a3ffd4]%s[/color]" %text)


##
func print_fail(text : String) -> void : 
	print_rich("[color=e64f59]%s[/color]" %text)


##
func print_info(text : String) -> void :
	print_rich("[color=6babed]%s[/color]" %text)
