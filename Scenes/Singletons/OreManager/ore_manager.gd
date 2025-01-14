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
signal ore_consumed(ore : Ore.List, quantity : int)
##
signal ore_updated(ore : Ore.List)


##
func create_ore(ore : Ore.List, quantity : int) -> Error : 
	if quantity <= 0 : return FAILED
	
	Game.ref.data.ores[ore] += quantity
	ore_created.emit(ore, quantity)
	ore_updated.emit(ore)
	
	return OK


##
func get_ore(ore : Ore.List) -> int : 
	return Game.ref.data.ores[ore]


##
func can_consume(ore : Ore.List, quantity : int) -> bool :
	if quantity < 0 : return false
	if quantity > Game.ref.data.ores[ore] : return false
	return true


##
func consume(ore : Ore.List, quantity : int) -> Error : 
	if not can_consume(ore, quantity) : return FAILED
	
	Game.ref.data.ores[ore] -= quantity
	ore_consumed.emit(ore, quantity)
	ore_updated.emit(ore)
	
	return OK
