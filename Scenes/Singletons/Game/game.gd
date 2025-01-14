class_name Game extends Node
## Game Singleton.

## Singleton reference.
static var ref : Game
## Singleton constructor.
func _init() -> void :
	if not ref : ref = self
	else : queue_free()


##
var data : Data = SaveAndLoad.load_data()


##
func _enter_tree() -> void :
	Ore.initialise_ores()
	OreVein.initialise_ore_veins()
	SwordRecipe.initialise_recipes()


##
func _ready() -> void :
	var ore : Ore = Ore.get_ore(Ore.List.TIER_2)
	ore.debug_print_ore()
	print("\n\n")
	OreVein.get_ore_vein(OreVein.List.TIER_2).debug_print_ore_vein()


##
func _exit_tree() -> void :
	SaveAndLoad.save_data()
