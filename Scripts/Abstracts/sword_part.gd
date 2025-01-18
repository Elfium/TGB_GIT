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
var key : int = -1
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
static var sword_parts : Dictionary[int, SwordPart] = {}


##
func _init(
		_key : int = -1,
		_tier : int = 1,
		_type : Type = Type.BLADE,
		_forge_rate : int = 1,
		_texture : Texture2D = preload("res://icon.svg"),
		_level : int = 1, 
		_name : String = "Unnamed part",

) -> void : 
	key = _key
	tier = _tier
	type = _type
	forge_rate = _forge_rate
	texture = _texture
	name = _name
	level = _level


##
static func initialise_sword_parts() -> Error : 
	if sword_parts.size() > 0 : return FAILED
	
	# Tier 1 Level 1
	sword_parts[0] = SwordPart.new(0, 1, Type.BLADE, 25, load("res://Assets/Swords/Blade/Blade_1.png"), 1)
	sword_parts[1] = SwordPart.new(1, 1, Type.HANDLE, 25, load("res://Assets/Swords/Handle/Handle_1.png"), 1)
	sword_parts[2] = SwordPart.new(2, 1, Type.POMMEL, 25, load("res://Assets/Swords/Pommel/Pommel_1.png"), 1)
	sword_parts[3] = SwordPart.new(3, 1, Type.GUARD, 25, load("res://Assets/Swords/Guard/Guard_1.png"), 1)
	
	# Tier 1 Level 2
	sword_parts[4] = SwordPart.new(4, 1, Type.BLADE, 50, load("res://Assets/Swords/Blade/Blade_3.png"), 2)
	sword_parts[5] = SwordPart.new(5, 1, Type.HANDLE, 50, load("res://Assets/Swords/Handle/Handle_2.png"), 2)
	sword_parts[6] = SwordPart.new(6, 1, Type.POMMEL, 50, load("res://Assets/Swords/Pommel/Pommel_2.png"), 2)
	sword_parts[7] = SwordPart.new(7, 1, Type.GUARD, 50, load("res://Assets/Swords/Guard/Guard_2.png"), 2)
	
	return OK
