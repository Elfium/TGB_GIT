extends Control
##


##
var _sword : Sword


##
func _ready() -> void :
	Inventory.ref.sword_inspected.connect(_on_sword_inspected)
	tooltip_text = "."


##
func _set_sword(sword : Sword) -> void : 
	_sword = sword
	
	(%HandlePart as TextureRect).texture = sword.get_handle_part().texture
	(%BladePart as TextureRect).texture = sword.get_blade_part().texture
	(%GuardPart as TextureRect).texture = sword.get_guard_part().texture
	(%PommelPart as TextureRect).texture = sword.get_pommel_part().texture


##
func _on_sword_inspected(sword : Sword) -> void : 
	_set_sword(sword)


func _make_custom_tooltip(_for_text : String) -> Object :
	var node : SwordTooltip = preload("res://Scenes/Components/SwordTooltip/sword_tooltip.tscn").instantiate()
	node.set_sword(_sword)
	
	return node
