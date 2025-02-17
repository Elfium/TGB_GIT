class_name Experience extends Node

static var ref : Experience 

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


signal experience_created(quantity : int, level : int)
signal level_up(new_level : int, previous_level : int)


func create(quantity : int) -> Error : 
	if quantity <= 0 : return FAILED
	
	Game.ref.data.experience += quantity
	experience_created.emit(quantity, get_level())
	
	return OK


func get_experience() -> int :
	return Game.ref.data.experience


func get_experience_for_next_level() -> int : 
	var next_level : int = get_level() + 1
	var experience : int = int(pow(next_level, 3))
	
	return experience


func get_level() -> int :
	var level : int = floor(pow(Game.ref.data.experience, 1.0/3.0))
	
	level_up.emit(level, Game.ref.data.level)
	Game.ref.data.level = level
	
	return level


func get_sword_experience(sword : Sword) -> void : 
	@warning_ignore("integer_division")
	create(round(sword.forge_rate / 100))
