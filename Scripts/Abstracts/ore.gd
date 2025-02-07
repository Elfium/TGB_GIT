class_name Ore extends Resource
## Ore resource.


## Enum containing all ores of the game.
enum List {
	TIER_1 = 0,
	TIER_2 = 1,
	TIER_3 = 2,
}


##
var enum_value : List = List.TIER_1
##
var tier : int = 1
##
var name : String = "Unnamed ore"
##
var texture : Texture2D = load("res://icon.svg")
##
static var ores : Array[Ore] = []


##
func debug_print_ore() -> void : 
	print("%s" %name)
	print("==========")
	print("Tier : %s" %tier)
	print("Texture : %s" %texture.resource_path)


## 
static func initialise_ores() -> Error : 
	if ores.size() > 0 : return FAILED 
	
	var tier_1 : Ore = Ore.new()
	tier_1.enum_value = List.TIER_1
	tier_1.tier = 1
	tier_1.name = "Iron Chunk"
	tier_1.texture = load("res://Assets/Ores/IronChunk.png")
	ores.append(tier_1)
	
	var tier_2 : Ore = Ore.new()
	tier_2.enum_value = List.TIER_2
	tier_2.tier = 2
	tier_2.texture = load("res://Assets/Ores/CelestialSteel.png")
	tier_2.name = "Celestial Steel"
	ores.append(tier_2)
	
	var tier_3 : Ore = Ore.new()
	tier_3.enum_value = List.TIER_3
	tier_3.tier = 3
	tier_3.texture = load("res://Assets/Ores/ObsidianChunk.png")
	tier_3.name = "Obsidian Chunk"
	ores.append(tier_3)
	
	_check_data()
	
	return OK


##
static func _check_data() -> void : 
	for ore : List in List.values() : 
		if not Game.ref.data.ores.has(ore) :
			Game.ref.data.ores[ore] = 0


##
static func get_ore(ore : List) -> Ore : 
	return ores[int(ore)]
