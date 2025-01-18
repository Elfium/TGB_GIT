class_name Inventory extends Node
##

##
static var ref : Inventory 
##
func _init() -> void :
	if not ref : ref = self 
	else : queue_free()


##
signal sword_added(sword : Sword)
##
signal sword_removed(sword : Sword)
##
signal sword_inspected(sword : Sword)


##
func add_sword(sword : Sword) -> Error :
	if Game.ref.data.swords.has(sword) : return FAILED
	
	Game.ref.data.swords.append(sword)
	sword_added.emit(sword)
	
	return OK


##
func remove_sword(sword : Sword) -> Error : 
	if not Game.ref.data.swords.has(sword) : return FAILED
	
	Game.ref.data.swords.erase(sword)
	sword_removed.emit(sword)
	
	return OK


##
func get_swords() -> Array[Sword] : 
	return Game.ref.data.swords


##
func inspect_sword(sword : Sword) -> void : 
	sword_inspected.emit(sword)
