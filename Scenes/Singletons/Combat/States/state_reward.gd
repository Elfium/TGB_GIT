class_name CombatStateReward extends CombatState


func enter_state() -> void : 
	super()
	print("Entering Reward State.")
	context.change_state(context.state_enemy_selection)


func exit_state() -> void : 
	super()
	print("Exiting Reward State.")


func can_switch_to(state : CombatState) -> bool : 
	if state == context.state_enemy_selection : return true
	return false
