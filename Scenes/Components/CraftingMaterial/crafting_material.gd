class_name UICraftingMaterial extends VBoxContainer
##


##
var _ore : Ore.List
##
var _quantity : int


##
func set_ore(ore : Ore.List, quantity : int) -> Error : 
	if _ore : return FAILED 
	
	_ore = ore
	_quantity = quantity
	OreManager.ref.ore_updated.connect(_on_ore_updated)
	(%Texture as TextureRect).texture = Ore.get_ore(_ore).texture
	_update_label()
	
	return OK


##
func _update_label() -> void : 
	(%CountLabel as Label).text = "%s / %s" %[OreManager.ref.get_ore(_ore), _quantity]


##
func _on_ore_updated(ore : Ore.List) -> void : 
	if _ore == ore : 
		_update_label()
