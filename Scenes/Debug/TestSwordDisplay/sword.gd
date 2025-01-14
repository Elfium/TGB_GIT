class_name DebugTestSwordDisplayUnit extends Control
## Class tailored for a specific debug test.


##
var sword : Sword


##
func set_sword(_sword : Sword) -> Error :
	if not _sword : return FAILED
	
	sword = _sword
	_reset_textures()
	tooltip_text = "."
	
	return OK


## Uses textures with the following order : blade, handle, pommel, guard.
func _reset_textures() -> Error : 
	if not sword : return FAILED
	
	var textures : Array[Texture2D] = sword.get_textures()
	
	($Blade_Texture as TextureRect).texture = textures[0]
	($Handle_Texture as TextureRect).texture = textures[1]
	($Pommel_Texture as TextureRect).texture = textures[2]
	($Guard_Texture as TextureRect).texture = textures[3] 
	
	return OK


##
func _make_custom_tooltip(_for_text : String) -> Object :
	var tooltip : SwordTooltip = preload("res://Scenes/Components/SwordTooltip/sword_tooltip.tscn").instantiate()
	
	tooltip.set_sword(sword)
	
	return tooltip
