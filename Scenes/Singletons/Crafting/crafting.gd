class_name Crafting extends Node
## Crafting singleton.

## Singleton reference.
static var ref : Crafting
## Singleton constructor
func _init() -> void :
	if not ref : ref = self 
	else : queue_free()


##
signal sword_crafted(sword : Sword)
##
signal sword_collected(sword : Sword)


##
func craft_sword(recipe : SwordRecipe) -> Error : 
	if Game.ref.data.crafted_sword : return FAILED #Previous sword wasn't collected.
	
	if not can_craft_recipe(recipe) : return FAILED
	if consume_materials(recipe) : return FAILED
	
	Game.ref.data.crafted_sword = Sword.create_sword(recipe)
	sword_crafted.emit(Game.ref.data.crafted_sword)
	
	return OK


##
func collect_sword() -> Error : 
	if not Game.ref.data.crafted_sword : return FAILED #No sword to collect.
	
	var sword : Sword = Game.ref.data.crafted_sword
	Game.ref.data.crafted_sword = null
	sword_collected.emit(sword)
	
	return OK


##
func consume_materials(recipe : SwordRecipe) -> Error : 
	for craft_material : SwordRecipe.CraftMaterial in recipe.materials : 
		var error : Error = OreManager.ref.consume(craft_material.ore, craft_material.quantity)
		if error : return error
	
	return OK


##
func can_craft_recipe(recipe : SwordRecipe) -> bool : 
	for craft_material : SwordRecipe.CraftMaterial in recipe.materials :
		var boolean : bool = OreManager.ref.can_consume(craft_material.ore, craft_material.quantity)
		if not boolean : return false
	
	return true
