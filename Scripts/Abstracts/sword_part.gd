class_name SwordPart extends Resource
## 


##
enum Type {
	BLADE,
	HANDLE,
	POMMEL,
	GUARD,
}


##
var tier : int = 1
##
var type : Type = Type.BLADE
##
var level : int = 1 
##
var name : String = "Unnamed part"
##
var texture : Texture2D = load("res://icon.svg")
##
var forge_rate : int = 1
##
static var sword_parts : Dictionary = {}


##
func _init(
		_tier : int = 1,
		_type : Type = Type.BLADE,
		_forge_rate : int = 1,
		_texture : Texture2D = preload("res://icon.svg"),
		_name : String = "Unnamed part",
		_level : int = 1, 
) -> void : 
	tier = _tier
	type = _type
	forge_rate = _forge_rate
	texture = _texture
	name = _name
	level = _level


##
static func initialise_sword_parts() -> Error : 
	if sword_parts.size() > 0 : return FAILED
	
	# Tier 1 Iron Sword
	sword_parts[0] = SwordPart.new(1, Type.BLADE, 25, load("res://Assets/Swords/Blade/Blade_1.png"))
	sword_parts[1] = SwordPart.new(1, Type.HANDLE, 25, load("res://Assets/Swords/Handle/Handle_1.png"))
	sword_parts[2] = SwordPart.new(1, Type.POMMEL, 25, load("res://Assets/Swords/Pommel/Pommel_1.png"))
	sword_parts[3] = SwordPart.new(1, Type.GUARD, 25, load("res://Assets/Swords/Guard/Guard_1.png"))
	
	# Tier 1 Other Sword
	
	return OK
