extends HBoxContainer
##


##
func _ready() -> void :
	_instantiate_children()


##
func _instantiate_children() -> void : 
	var scene : PackedScene = load("res://Scenes/Components/VeinSelection/vein_selection.tscn")
	
	for vein : OreVein in OreVein.ore_veins : 
		var node : UIVeinSelection = scene.instantiate()
		node.set_vein(vein)
		add_child(node)
