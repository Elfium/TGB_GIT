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
	SwordPart.initialise_sword_parts()
	Ore.initialise_ores()
	OreVein.initialise_ore_veins()
	SwordRecipe.initialise_recipes()
	Upgrade.initialise_upgrades()


##
func _ready() -> void :
	Upgrade.apply_upgrades()


##
func _input(event : InputEvent) -> void :
	if event.is_action_pressed("show_stats") : 
		print("Swords crafted : %s" %Game.ref.data.stats.swords_crafted)
		print("Highest forge rate crafted : %s" %Game.ref.data.stats.highest_forge_rate_craft)
		print("Masterworks : %s" %Game.ref.data.stats.masterwork_crafts)
		print("Total craft value : %s" %Game.ref.data.stats.total_craft_value)


##
func _exit_tree() -> void :
	SaveAndLoad.save_data()
