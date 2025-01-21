class_name UiInventoryOre extends TextureRect
##


##
var _ore : Ore


##
func inject_data(ore : Ore) -> void : 
	if ore == null : return
	
	_ore = ore
	texture = ore.texture
	_update_label()
	OreManager.ref.ore_updated.connect(_on_ore_updated)


##
func _update_label() -> void : 
	if not _ore : return
	(%Label as Label).text = str(Game.ref.data.ores[_ore.enum_value])


##
func _on_ore_updated(ore_key : Ore.List) -> void : 
	if _ore.enum_value == ore_key : _update_label()
