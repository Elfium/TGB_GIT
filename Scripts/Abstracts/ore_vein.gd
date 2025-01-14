class_name OreVein extends Resource 
## Resources containing information of an ore vein. 


##
enum List {
	TIER_1 = 0,
	TIER_2 = 1,
}


##
var name : String = "Unnamed ore vein"
##
var tier : int = 1
##
var texture : Texture2D
##
var duration : float = 5.0
##
var content : Array[Loot] = []
##
static var ore_veins : Array[OreVein] = []


##
class Loot : 
	##
	var ore : Ore
	##
	var odd : int = 100
	##
	var quantity : Vector2i = Vector2i (1, 2)


##
func loot() -> void : 
	for _loot : Loot in content : 
		var roll : int = randi_range(1, 100)
		if roll <= _loot.odd : 
			var quantity : int = randi_range(_loot.quantity.x, _loot.quantity.y)
			OreManager.ref.create_ore(_loot.ore.enum_value, quantity)
			print("Looting %sx %s. (New value : %s)" %[quantity, _loot.ore.name, OreManager.ref.get_ore(_loot.ore.enum_value)])


##
func debug_print_ore_vein() -> void : 
	print("%s" %name)
	print("==========")
	print("Tier : %s" %tier)
	print("Texture : %s" %texture.resource_path)
	print("Time to mine : %0.0f" %duration)
	for _loot : Loot in content :
		print("===============")
		_loot.ore.debug_print_ore()
		print("Odd : %s" %_loot.odd)
		print("Quantity : %s" %_loot.quantity)


##
static func initialise_ore_veins() -> Error : 
	if ore_veins.size() > 0 : return FAILED
	
	var vein_1 : OreVein = OreVein.new()
	vein_1.name = "Vein 1 - Copper"
	vein_1.tier = 1
	vein_1.texture = load("res://icon.svg")
	vein_1.duration = 5.0
	vein_1.content.append(Loot.new())
	vein_1.content[0].ore = Ore.get_ore(Ore.List.TIER_1)
	ore_veins.append(vein_1)
	
	var vein_2 : OreVein = OreVein.new()
	vein_2.name = "Vein 2 - Iron"
	vein_2.tier = 2
	vein_2.texture = load("res://icon.svg")
	vein_2.duration = 3.0
	vein_2.content.append(Loot.new())
	vein_2.content[0].ore = Ore.get_ore(Ore.List.TIER_2)
	vein_2.content[0].odd = 100
	vein_2.content.append(Loot.new())
	vein_2.content[1].ore = Ore.get_ore(Ore.List.TIER_1)
	vein_2.content[1].odd = 75
	vein_2.content[1].quantity = Vector2(2, 3)
	ore_veins.append(vein_2)
	
	return OK


##
static func get_ore_vein(ore_vein : List) -> OreVein : 
	return ore_veins[int(ore_vein)]
