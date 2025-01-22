class_name CombatStateWindUp extends CombatState


var _progress : float


func enter_state() -> void : 
	super()
	print("Entering Wind Up State.")
	_progress = 0.0


func _process(delta : float) -> void :
	_progress += delta
	if _progress >= 1.0 :
		context.change_state(context.state_attack)


func exit_state() -> void : 
	super()
	print("Exiting Wind Up State.")
	_progress = 0.0


func can_switch_to(state : CombatState) -> bool : 
	if state == context.state_move or state == context.state_idle or state == context.state_attack : return true
	return false
