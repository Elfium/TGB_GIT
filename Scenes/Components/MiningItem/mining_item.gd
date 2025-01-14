class_name MiningItem extends TextureRect
##


##
var ore : Ore


##
func set_ore(_ore : Ore) -> void : 
	ore = _ore
	_reset_texture()


##
func set_quantity(quantity : int) -> void : 
	(%OreCount as Label).text = str(quantity)


##
func _reset_texture() -> void : 
	texture = ore.texture
