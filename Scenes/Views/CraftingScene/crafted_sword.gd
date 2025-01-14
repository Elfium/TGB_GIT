extends Control
##


##
func _ready() -> void :
	tooltip_text = "."


##
func _make_custom_tooltip(_for_text : String) -> Object :
	var node : SwordTooltip = preload("res://Scenes/Components/SwordTooltip/sword_tooltip.tscn").instantiate()
	
	node.set_sword(Game.ref.data.crafted_sword)
	
	return node
