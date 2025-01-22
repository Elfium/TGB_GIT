class_name CombatStateAttack extends CombatState


func enter_state() -> void : 
	super()
	print("Entering Attack State.")
	_chose_attacker()


func _chose_attacker() -> void :
	var roll : int = randi_range(0, 9)
	
	if roll < 2 :
		_enemy_attack()
	else : 
		_player_attack()


func _enemy_attack() -> void :
	Game.ref.data.combat.player_current_health -= randi_range(context.enemy.damage.x, context.enemy.damage.y)
	_check_player_health()


func _player_attack() -> void : 
	context.enemy.current_health -= 5
	_check_enemy_health()


func _check_enemy_health() -> void : 
	if context.enemy.current_health <= 0 :
		print_rich("[color=ff18a6]Enemy defeated[/color]")
		context.change_state(context.state_reward)
		return
	print_rich("[color=ff18a6]Enemy health : %s[/color]" %context.enemy.current_health)
	context.change_state(context.state_wind_up)


func _check_player_health() -> void : 
	if Game.ref.data.combat.player_current_health <= 0 :
		print_rich("[color=ff18a6]Player defeated[/color]")
		Game.ref.data.combat.player_current_health = 0
		context.change_state(context.state_idle)
		return
	print_rich("[color=ff18a6]Player health : %s[/color]" %Game.ref.data.combat.player_current_health)
	context.change_state(context.state_wind_up)


func exit_state() -> void : 
	super()
	print("Exiting Attack State.")


func can_switch_to(state : CombatState) -> bool : 
	if state == context.state_reward or state == context.state_wind_up or state == context.state_idle : return true
	return false
