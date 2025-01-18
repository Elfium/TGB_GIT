class_name SwordRecipe extends Resource
## Contains crafting materials for a craft.


## List of available recipes.
enum List {
	TIER_1_LEVEL_1,
	TIER_1_LEVEL_2,
}


##
var tier : int = 1
##
var name : String = "Unnamed Sword"
##
var texture : Texture2D = load("res://Assets/UI/Others/Sword_Blueprint_Small.png")
##
var materials : Array[CraftMaterial] = []
##
var blade_parts : Array[SwordPart] = []
##
var handle_parts : Array[SwordPart] = []
##
var pommel_parts : Array[SwordPart] = []
##
var guard_parts : Array[SwordPart] = []
##
static var recipes : Array[SwordRecipe] = []


##
class CraftMaterial :
	##
	var ore : Ore.List
	##
	var quantity : int
	
	
	##
	func _init(_ore : Ore.List = Ore.List.TIER_1, _quantity : int = 1) -> void :
		ore = _ore
		quantity = _quantity


##
static func initialise_recipes() -> Error : 
	if recipes.size() > 0 : return FAILED 
	
	## Tier 1 Level 1
	var recipe : SwordRecipe = SwordRecipe.new()
	recipe.tier = 1
	recipe.name = "Iron Sword"
	recipe.materials = [
		CraftMaterial.new(Ore.List.TIER_1, 10)
	]
	recipe.blade_parts.append(SwordPart.sword_parts[0])
	recipe.handle_parts.append(SwordPart.sword_parts[1])
	recipe.pommel_parts.append(SwordPart.sword_parts[2])
	recipe.guard_parts.append(SwordPart.sword_parts[3])
	recipes.append(recipe)
	
	## Tier 1 Level 2
	recipe = SwordRecipe.new()
	recipe.tier = 1
	recipe.name = "Iron Sword - Level 2"
	recipe.materials = [
		CraftMaterial.new(Ore.List.TIER_1, 10)
	]
	## Level 1 Parts
	recipe.blade_parts.append(SwordPart.sword_parts[0])
	recipe.handle_parts.append(SwordPart.sword_parts[1])
	recipe.pommel_parts.append(SwordPart.sword_parts[2])
	recipe.guard_parts.append(SwordPart.sword_parts[3])
	## Level 2 Parts
	recipe.blade_parts.append(SwordPart.sword_parts[4])
	recipe.handle_parts.append(SwordPart.sword_parts[5])
	recipe.pommel_parts.append(SwordPart.sword_parts[6])
	recipe.guard_parts.append(SwordPart.sword_parts[7])
	recipes.append(recipe)
	
	return OK


##
static func get_recipe(recipe : List) -> SwordRecipe : 
	return recipes[int(recipe)]
