extends GridContainer
##


##
func _ready() -> void : 
	_initialise_ores()


##
func _initialise_ores() -> void : 
	var scene : PackedScene = load("uid://c21chdi413jnd")
	
	for ore_key : Ore.List in Ore.List.values() : 
		var node : UiInventoryOre = scene.instantiate()
		node.inject_data(Ore.ores[ore_key])
		add_child(node)
