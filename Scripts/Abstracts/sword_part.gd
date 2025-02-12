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
var tier : int = 0
##
var type : Type = Type.BLADE
##
var level : int = 0
##
var name : String = "Unnamed part"
##
var texture : Texture2D = load("res://icon.svg")
##
var forge_rate : Vector2i = Vector2i(5, 5)
##
var drop_weight : int = 1
##
static var sword_parts : Dictionary[int, SwordPart] = {}


##
func _init(
		_key : int = -1,
		_tier : int = 1,
		_type : Type = Type.BLADE,
		_forge_rate : Vector2i = Vector2i(5, 5),
		_texture : Texture2D = preload("res://icon.svg"),
		_level : int = 1, 
		_drop_weight : int = 1,
		_name : String = "Unnamed part",

) -> void : 
	key = _key
	tier = _tier
	type = _type
	forge_rate = _forge_rate
	texture = _texture
	name = _name
	level = _level
	drop_weight = _drop_weight


##
static func initialise_sword_parts() -> Error : 
	if sword_parts.size() > 0 : return FAILED
	
	# Tier 1 Level 1
	sword_parts[0] = SwordPart.new(0, 1, Type.BLADE, Vector2i(25, 50), load("uid://cktb61ilvvotl"), 1, 5)
	sword_parts[1] = SwordPart.new(1, 1, Type.HANDLE, Vector2i(25, 50), load("uid://1mdi5giqd5np"), 1, 5)
	sword_parts[2] = SwordPart.new(2, 1, Type.POMMEL, Vector2i(25, 50), load("uid://da0fjl8x3yhre"), 1, 5)
	sword_parts[3] = SwordPart.new(3, 1, Type.GUARD, Vector2i(25, 50), load("uid://dug4iyewdvr7d"), 1, 5)
	
	# Tier 1 Level 2
	sword_parts[4] = SwordPart.new(4, 1, Type.BLADE, Vector2i(100, 150), load("uid://dprs20nwcb8bf"), 2, 3)
	sword_parts[5] = SwordPart.new(5, 1, Type.HANDLE, Vector2i(100, 150), load("uid://bac6qfe2rwjbv"), 2, 3)
	sword_parts[6] = SwordPart.new(6, 1, Type.POMMEL, Vector2i(100, 150), load("uid://clg1sqjhtlfjm"), 2, 3)
	sword_parts[7] = SwordPart.new(7, 1, Type.GUARD, Vector2i(100, 150), load("uid://bohvrhj6f1l3c"), 2, 3)
	
	# Tier 1 Level 3
	sword_parts[8] = SwordPart.new(8, 1, Type.BLADE, Vector2i(200, 250), load("uid://dnsx604gggd8n"), 3, 2)
	sword_parts[9] = SwordPart.new(9, 1, Type.HANDLE, Vector2i(200, 250), load("uid://dmep6pf8ur35g"), 3, 2)
	sword_parts[10] = SwordPart.new(10, 1, Type.POMMEL, Vector2i(200, 250), load("uid://bgxlh5skgpf3x"), 3, 2)
	sword_parts[11] = SwordPart.new(11, 1, Type.GUARD, Vector2i(200, 250), load("uid://c412b8heuqbga"), 3, 2)
	
	return OK
