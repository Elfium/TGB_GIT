extends VBoxContainer
##


##
func _ready() -> void :
	_instantiate_recipes()


##
func _instantiate_recipes() -> void  :
	var scene : PackedScene = load("res://Scenes/Components/CraftingRecipe/crafting_recipe.tscn")
	
	for recipe : SwordRecipe in SwordRecipe.recipes :
		var node : UICraftingRecipe = scene.instantiate()
		node.set_recipe(recipe)
		add_child(node)
