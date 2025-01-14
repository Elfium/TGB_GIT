class_name UIVeinSelection extends Panel
##


##
var _vein : OreVein


##
func set_vein(vein : OreVein) -> void : 
	_vein = vein
	(%Texture as TextureRect).texture = vein.texture


##
func _gui_input(event : InputEvent) -> void :
	if event.is_action_pressed("left_click") : 
		Mining.ref.set_vein(_vein)
