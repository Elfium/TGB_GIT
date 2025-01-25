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
signal sword_lock_updated(sword : Sword)
##
signal swords_rearranged


##
var _inspected_sword : Sword


##
func _ready() -> void :
	sort_by_forge_rate()


##
func add_sword(sword : Sword) -> Error :
	if Game.ref.data.swords.has(sword) : return FAILED
	
	Game.ref.data.swords.append(sword)
	sword_added.emit(sword)
	
	sort_by_forge_rate()
	
	return OK


##
func remove_sword(sword : Sword) -> Error : 
	if not Game.ref.data.swords.has(sword) : return FAILED
	
	Game.ref.data.swords.erase(sword)
	if sword == _inspected_sword : _inspected_sword = null
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
	
	swords_rearranged.emit()
	 
	return OK


##
func get_swords() -> Array[Sword] : 
	return Game.ref.data.swords


##
func inspect_sword(sword : Sword) -> void : 
	_inspected_sword = sword
	sword_inspected.emit(sword)


##
func sell_sword() -> Error :
	if not Game.ref.data.swords.has(_inspected_sword) : return FAILED
	if _inspected_sword.locked : return FAILED
	
	Currency.ref.create(_inspected_sword.get_currency_value())
	remove_sword(_inspected_sword)
	sword_sold.emit(_inspected_sword)
	
	return OK


##
func sword_lock_toggle() -> void :
	_inspected_sword.locked = not _inspected_sword.locked
	sword_lock_updated.emit(_inspected_sword)


##
func sell_all_swords() -> void : 
	var array_duplicate : Array[Sword] = Game.ref.data.swords.duplicate()
	
	for sword : Sword in array_duplicate : 
		if not sword.locked :
			Currency.ref.create(sword.get_currency_value())
			remove_sword(sword)
			sword_sold.emit(sword)
