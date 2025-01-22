class_name CombatState extends Node


var context : Combat


func _ready() -> void :
	context = get_parent()


func enter_state() -> void :
	set_process(true)



func exit_state() -> void : 
	set_process(false)


func can_switch_to(_state : CombatState) -> bool : 
	return true
