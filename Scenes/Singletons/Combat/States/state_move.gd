class_name CombatStateMove extends CombatState


func enter_state() -> void : 
	super()
	print("Entering Move State.")
	context.change_state(context.state_enemy_selection)


func exit_state() -> void : 
	super()
	print("Exiting Move State.")


func can_switch_to(state : CombatState) -> bool : 
	if state == context.state_enemy_selection : return true
	return false
