class_name CombatStateEnemySelection extends CombatState


func enter_state() -> void : 
	super()
	print_rich("Entering Enemy Selection State.")
	_generate_enemy()


func _generate_enemy() -> void : 
	var roll : int = randi_range(0, 1)
	var enemy : Enemy 
	if roll : enemy = Enemy.dictionary[Enemy.Enum.ZOMBIE].duplicate()
	else : enemy = Enemy.dictionary[Enemy.Enum.SKELETON].duplicate()
	
	context.enemy = enemy
	print_rich("[color=ff18a6]New enemy selected : %s[/color]" %context.enemy.name)
	
	context.change_state(context.state_wind_up)


func exit_state() -> void : 
	super()
	print("Exiting Selection State.")


func can_switch_to(state : CombatState) -> bool : 
	if state == context.state_wind_up : return true
	return false
