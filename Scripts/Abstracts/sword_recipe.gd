class_name SwordRecipe extends Resource
## Contains crafting materials for a craft.


## List of available recipes.
enum List {
	TIER_1,
	TIER_2,
}


##
var tier : int = 1
##
var name : String = "Unnamed Recipe"
##
var texture : Texture2D = load("res://Assets/UI/Others/Sword_Blueprint_Small.png")
##
var materials : Array[CraftMaterial] = []
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
	
	var recipe_1 : SwordRecipe = SwordRecipe.new()
	recipe_1.tier = 1
	recipe_1.name = "Tier 1 Sword"
	recipe_1.materials = [
		CraftMaterial.new(Ore.List.TIER_1, 10)
	]
	recipes.append(recipe_1)
	
	var recipe_2 : SwordRecipe = SwordRecipe.new()
	recipe_2.tier = 2
	recipe_2.name = "Tier 2 Sword"
	recipe_2.materials = [
		CraftMaterial.new(Ore.List.TIER_1, 5),
		CraftMaterial.new(Ore.List.TIER_2, 15),
	]
	recipes.append(recipe_2)
	
	return OK


##
static func get_recipe(recipe : List) -> SwordRecipe : 
	return recipes[int(recipe)]
