class_name InventorySword extends Control
##


##
var _sword : Sword


##
func set_sword(sword : Sword) -> Error : 
	_sword = sword
	_update_textures()
	
	return OK


##
func _update_textures() -> void : 
	if not _sword : return
	
	(%HandlePart as TextureRect).texture = _sword.get_handle_part().texture
	(%BladePart as TextureRect).texture = _sword.get_blade_part().texture
	(%GuardPart as TextureRect).texture = _sword.get_guard_part().texture
	(%PommelPart as TextureRect).texture = _sword.get_pommel_part().texture
