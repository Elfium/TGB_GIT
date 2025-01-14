class_name Crafting extends Node
## Crafting singleton.

## Singleton reference.
static var ref : Crafting
## Singleton constructor
func _init() -> void :
	if not ref : ref = self 
	else : queue_free()


##
signal sword_crafted(sword : Sword)
##
signal sword_collected(sword : Sword)


##
func craft_sword(tier : int = 1) -> Error : 
	if Game.ref.data.crafted_sword : return FAILED #Previous sword wasn't collected.
	
	Game.ref.data.crafted_sword = SwordCraft.create_sword(tier)
	sword_crafted.emit(Game.ref.data.crafted_sword)
	
	return OK


##
func collect_sword() -> Error : 
	if not Game.ref.data.crafted_sword : return FAILED #No sword to collect.
	
	var sword : Sword = Game.ref.data.crafted_sword
	Game.ref.data.crafted_sword = null
	sword_collected.emit(sword)
	
	return OK
