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
signal sword_sold(sword : Sword)


##
func _ready() -> void :
	sort_by_forge_rate()


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
func sort_by_forge_rate(inverted : bool = false) -> Error :
	if not inverted :
		Game.ref.data.swords.sort_custom(
			func(a : Sword, b : Sword) : 
				return true if a.forge_rate > b.forge_rate else false
		)
	
	else : 
		Game.ref.data.swords.sort_custom(
			func(a : Sword, b : Sword) : 
				return true if a.forge_rate < b.forge_rate else false
		)
	 
	return OK


##
func get_swords() -> Array[Sword] : 
	return Game.ref.data.swords


##
func inspect_sword(sword : Sword) -> void : 
	sword_inspected.emit(sword)


##
func sell_sword(sword : Sword) -> Error :
	if not Game.ref.data.swords.has(sword) : return FAILED
	
	Currency.ref.create(sword.get_currency_value())
	remove_sword(sword)
	sword_sold.emit(sword)
	
	return OK
