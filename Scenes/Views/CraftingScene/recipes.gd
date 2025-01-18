extends VBoxContainer
##


##
var _recipes : Dictionary[SwordRecipe.List, UICraftingRecipe] = {}


##
func _ready() -> void :
	Signals.ref.recipes_updated.connect(_on_recipes_updated)
	_instantiate_recipes()


##
func _update_recipes() -> void : 
	_hide_all_recipes()
	_show_available_recipes()


##
func _hide_all_recipes() -> void : 
	for key : SwordRecipe.List in _recipes : 
		_recipes[key].visible = false


##
func _show_available_recipes() -> void : 
	var data : Data = Game.ref.data
	
	if data.sword_recipes_unlock[SwordRecipe.List.TIER_1_LEVEL_2] : 
		_recipes[SwordRecipe.List.TIER_1_LEVEL_2].visible = true
	elif data.sword_recipes_unlock[SwordRecipe.List.TIER_1_LEVEL_1] : 
		_recipes[SwordRecipe.List.TIER_1_LEVEL_1].visible = true


##
func _instantiate_recipes() -> void  :
	var scene : PackedScene = load("res://Scenes/Components/CraftingRecipe/crafting_recipe.tscn")
	
	for recipe : SwordRecipe in SwordRecipe.recipes :
		var node : UICraftingRecipe = scene.instantiate()
		node.set_recipe(recipe)
		_recipes[recipe.key] = node
		add_child(node)
	
	_update_recipes()


##
func _on_recipes_updated() -> void : 
	_update_recipes()
