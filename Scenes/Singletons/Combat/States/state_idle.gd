class_name CombatStateIdle extends CombatState


func enter_state() -> void : 
	super()
	print("Entering Idle State.")


func exit_state() -> void : 
	super()
	print("Exiting Idle State.")


func can_switch_to(state : CombatState) -> bool : 
	if state == context.state_move : return true
	return false
