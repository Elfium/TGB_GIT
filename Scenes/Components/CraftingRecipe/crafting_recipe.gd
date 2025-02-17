class_name UICraftingRecipe extends PanelContainer
##


##
var _recipe : SwordRecipe


##
func _ready() -> void :
	(%CraftButton as Button).pressed.connect(_on_craft_button_pressed)


##
func set_recipe(recipe : SwordRecipe) -> void  :
	_recipe = recipe
	(%RecipeName as Label).text = _recipe.name
	(%Recipe_Level_Bar as TextureProgressBar).value = _recipe.level
	_instantiate_materials()


##
func _instantiate_materials() -> void : 
	var container : Control = %Materials
	var scene : PackedScene = load("res://Scenes/Components/CraftingMaterial/crafting_material.tscn")
	
	for craft_material : SwordRecipe.CraftMaterial in _recipe.materials : 
		var node : UICraftingMaterial = scene.instantiate()
		node.set_ore(craft_material.ore, craft_material.quantity)
		container.add_child(node)


func _on_craft_button_pressed() -> void : 
	Crafting.ref.craft_sword(_recipe)
	Anims.button_click(%CraftButton as Button, true, true, Color(4,3,2))
	SoundMachine.play_sound(0,1)
