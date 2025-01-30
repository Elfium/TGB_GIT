class_name UICraftingMaterial extends Control
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
	%MaterialTexture.texture = Ore.get_ore(_ore).texture
	_update_label()
	
	return OK


##
func _update_label() -> void : 
	(%CountLabel_have as Label).text = str(OreManager.ref.get_ore(_ore))
	(%CountLabel_need as Label).text = str(_quantity)


##
func _on_ore_updated(ore : Ore.List) -> void : 
	if _ore == ore : 
		_update_label()
