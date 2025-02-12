extends Control
##


##
var _sword : Sword
@onready var _inventory_buttons_panel : InventoryRightMenu = %InventoryButtonsPanel
@onready var _sword_stats : InventoryLeftMenu = %SwordStats


##
func _ready() -> void :
	(%SellButton as Button).pressed.connect(_on_sell_button_pressed)
	Inventory.ref.sword_inspected.connect(_on_sword_inspected)
	Inventory.ref.sword_removed.connect(_on_sword_removed)
	_remove_sword()


##
func _set_sword(sword : Sword) -> void : 
	_sword = sword
	
	(%HandlePart as TextureRect).texture = sword.get_handle_part().texture
	(%BladePart as TextureRect).texture = sword.get_blade_part().texture
	(%GuardPart as TextureRect).texture = sword.get_guard_part().texture
	(%PommelPart as TextureRect).texture = sword.get_pommel_part().texture
	
	(%EquipButton as Control).disabled = false
	(%FavouriteButton as Control).disabled = false
	(%SellButton as Control).disabled = false
	
	_update_enchantment(sword)
	
	tooltip_text = "."
	_inventory_buttons_panel.show_buttons()
	_sword_stats.unfold()


func _update_enchantment(sword : Sword) -> void : 
	if sword.enchantment : 
		(%BladePart as TextureRect).material = sword.enchantment.get_shader()
	else: 
		(%BladePart as TextureRect).material = null


##
func _remove_sword() -> void : 
	(%HandlePart as TextureRect).texture = null
	(%BladePart as TextureRect).texture = null
	(%GuardPart as TextureRect).texture = null
	(%PommelPart as TextureRect).texture = null
	
	(%EquipButton as Control).disabled = true
	(%FavouriteButton as Control).disabled = true
	(%SellButton as Control).disabled = true
	
	tooltip_text = ""
	_inventory_buttons_panel.hide_buttons()
	_sword_stats.fold()


##
func _on_sword_removed(sword : Sword) -> void :
	if sword == _sword : 
		_remove_sword()


##
func _on_sword_inspected(sword : Sword) -> void : 
	_set_sword(sword)
	Anims.button_click(self as Control, true, false, Color(1,1,1,0))
	$Control/AnimationPlayer.stop()
	$Control/AnimationPlayer.play("wave")

##
func _on_sell_button_pressed() -> void : 
	Inventory.ref.sell_sword()


##
func _make_custom_tooltip(_for_text : String) -> Object :
	var node : SwordTooltip = preload("res://Scenes/Components/SwordTooltip/sword_tooltip.tscn").instantiate()
	node.set_sword(_sword)
	
	return node
