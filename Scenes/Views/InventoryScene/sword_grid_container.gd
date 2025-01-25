extends GridContainer
##


##
var _inventory_sword_scene : PackedScene = load("res://Scenes/Components/InventorySword/InventorySword.tscn")
##
var _swords : Dictionary[Sword, InventorySword] = {}


##
func _ready() -> void :
	Inventory.ref.sword_added.connect(_on_sword_added)
	Inventory.ref.sword_removed.connect(_on_sword_removed)
	Inventory.ref.swords_rearranged.connect(_on_swords_rearranged)
	_load_swords()


##
func _load_swords() -> void : 
	for sword : Sword in Inventory.ref.get_swords() : 
		_instantiate_sword(sword)


##
func _instantiate_sword(sword : Sword) -> void : 
	var node : InventorySword = _inventory_sword_scene.instantiate()
	node.set_sword(sword)
	_swords[sword] = node
	add_child(node)


##
func _remove_sword(sword : Sword) -> void : 
	if not _swords.has(sword) :  return
	
	_swords[sword].queue_free()
	_swords.erase(sword)


##
func _rearrange_swords() -> void : 
	var dictionary_size : int = _swords.size()
	
	for sword : Sword in Game.ref.data.swords : 
		if _swords.has(sword) : 
			move_child(_swords[sword], dictionary_size - 1)
		else : 
			printerr("Oh no. A sword is missing in the UI")


##
func _on_sword_added(sword : Sword) -> void : 
	_instantiate_sword(sword)


##
func _on_sword_removed(sword : Sword) -> void : 
	_remove_sword(sword)


##
func _on_swords_rearranged() -> void : 
	_rearrange_swords()
