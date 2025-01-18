class_name InventorySword extends Panel
##


##
var _sword : Sword
##
var _style_empty : StyleBoxEmpty = preload("res://Themes/Panels/empty_style.tres")
##
var _style_border : StyleBoxFlat = preload("res://Themes/Panels/inventory_item_border.tres")


##
func _ready() -> void :
	Inventory.ref.sword_inspected.connect(_on_sword_inspected)


##
func _gui_input(event : InputEvent) -> void :
	if event.is_action_pressed("left_click") :
		#Inventory.ref.inspect_sword(_sword)
		Inventory.ref.remove_sword(_sword)


##
func set_sword(sword : Sword) -> Error : 
	_sword = sword
	_update_textures()
	
	return OK


##
func _update_panel_style(inspected_sword : Sword) -> void :
	if _sword == inspected_sword : 
		add_theme_stylebox_override("panel", _style_border)
	else : 
		add_theme_stylebox_override("panel", _style_empty)


##
func _update_textures() -> void : 
	if not _sword : return
	
	(%HandlePart as TextureRect).texture = _sword.get_handle_part().texture
	(%BladePart as TextureRect).texture = _sword.get_blade_part().texture
	(%GuardPart as TextureRect).texture = _sword.get_guard_part().texture
	(%PommelPart as TextureRect).texture = _sword.get_pommel_part().texture


##
func _on_sword_inspected(sword : Sword) -> void : 
	_update_panel_style(sword)
