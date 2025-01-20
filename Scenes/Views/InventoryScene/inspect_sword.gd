extends Control
##


##
var _sword : Sword


##
func _ready() -> void :
	(%SellButton as Button).pressed.connect(_on_sell_button_pressed)
	Inventory.ref.sword_inspected.connect(_on_sword_inspected)
	Inventory.ref.sword_removed.connect(_on_sword_removed)
	tooltip_text = "."


##
func _set_sword(sword : Sword) -> void : 
	_sword = sword
	
	(%HandlePart as TextureRect).texture = sword.get_handle_part().texture
	(%BladePart as TextureRect).texture = sword.get_blade_part().texture
	(%GuardPart as TextureRect).texture = sword.get_guard_part().texture
	(%PommelPart as TextureRect).texture = sword.get_pommel_part().texture


##
func _remove_sword() -> void : 
	(%HandlePart as TextureRect).texture = null
	(%BladePart as TextureRect).texture = null
	(%GuardPart as TextureRect).texture = null
	(%PommelPart as TextureRect).texture = null


##
func _on_sword_removed(sword : Sword) -> void :
	if sword == _sword : 
		_remove_sword()


##
func _on_sword_inspected(sword : Sword) -> void : 
	_set_sword(sword)


##
func _on_sell_button_pressed() -> void : 
	Inventory.ref.sell_sword(_sword)


##
func _make_custom_tooltip(_for_text : String) -> Object :
	var node : SwordTooltip = preload("res://Scenes/Components/SwordTooltip/sword_tooltip.tscn").instantiate()
	node.set_sword(_sword)
	
	return node
