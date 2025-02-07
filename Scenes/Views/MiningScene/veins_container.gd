extends VBoxContainer
##


##
func _ready() -> void :
	_instantiate_children()


##
func _instantiate_children() -> void : 
	var scene : PackedScene = load("uid://tejkgboislea")
	
	for vein : OreVein in OreVein.ore_veins : 
		var node : OreVeinUi = scene.instantiate()
		node.inject_data(vein)
		add_child(node)
