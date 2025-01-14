class_name OreManager extends Node
## Singleton managin Ores in Data.

## Static ref.
static var ref : OreManager
## Singleton Constructor.
func _init() -> void :
	if not ref : ref = self
	else : queue_free()


##
signal ore_created(ore : Ore.List, quantity : int)


##
func create_ore(ore : Ore.List, quantity : int) -> Error : 
	if quantity <= 0 : return FAILED
	
	Game.ref.data.ores[ore] += quantity
	ore_created.emit(ore, quantity)
	
	return OK


##
func get_ore(ore : Ore.List) -> int : 
	return Game.ref.data.ores[ore]
