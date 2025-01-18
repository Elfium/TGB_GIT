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
func _on_sword_added(sword : Sword) -> void : 
	_instantiate_sword(sword)


##
func _on_sword_removed(sword : Sword) -> void : 
	_remove_sword(sword)
