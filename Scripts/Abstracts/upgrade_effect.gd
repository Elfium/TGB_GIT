class_name UpgradeEffect extends Node
##


##
enum Effects {
	UNLOCK_RECIPE,
}


##
enum Values {
	RECIPE_KEY,
}


##
var effect : Effects
##
var values : Dictionary[Values, Variant]


##
func apply_effect() -> void : 
	match effect : 
		Effects.UNLOCK_RECIPE : unlock_recipe()


##
func unlock_recipe() -> void : 
	Game.ref.data.sword_recipes_unlock[values[Values.RECIPE_KEY]] = true
	Signals.ref.recipes_updated.emit()
