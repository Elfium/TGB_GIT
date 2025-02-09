class_name InventorySword extends Control
##


##
var _sword : Sword
##
var _just_pressed : bool = false
##
var _style_panel : StyleBoxFlat = preload("res://Themes/Panels/inventory_item_panel.tres")
##
var _style_border : StyleBoxFlat = preload("res://Themes/Panels/inventory_item_highlight.tres")


##
func _ready() -> void :
	Inventory.ref.sword_inspected.connect(_on_sword_inspected)
	Inventory.ref.sword_lock_updated.connect(_on_sword_lock_updated)


##
func _gui_input(event : InputEvent) -> void :
	if event.is_action_pressed("left_click") : 
		_just_pressed = true
		await get_tree().create_timer(0.1).timeout
		_just_pressed = false
	if event.is_action_released("left_click") and _just_pressed :
		Inventory.ref.inspect_sword(_sword)
		#Inventory.ref.remove_sword(_sword)


##
func set_sword(sword : Sword) -> Error : 
	_sword = sword
	_update_textures()
	_update_forge_rate()
	_update_lock()
	
	return OK


##
func _update_panel_style(inspected_sword : Sword) -> void :
	if _sword == inspected_sword : 
		($InventorySword as Panel).add_theme_stylebox_override("panel", _style_border)
		_sword_click()
	else : 
		($InventorySword as Panel).add_theme_stylebox_override("panel", _style_panel)

##
func _sword_click() -> void:
	Anims.button_click($InventorySword as Panel, true, true, Color(4,3,2))
	SoundMachine.play_sound(0)



##
func _update_textures() -> void : 
	if not _sword : return
	
	(%HandlePart as TextureRect).texture = _sword.get_handle_part().texture
	(%BladePart as TextureRect).texture = _sword.get_blade_part().texture
	(%GuardPart as TextureRect).texture = _sword.get_guard_part().texture
	(%PommelPart as TextureRect).texture = _sword.get_pommel_part().texture

##
func _update_forge_rate() -> void:
	(%inventory_sword_fr as Label).text = str(_sword.forge_rate)


##
func _update_lock() -> void : 
	(%inner_panel as Control).self_modulate = Color.WEB_MAROON if _sword.locked else Color(1, 1, 1)


##
func _on_sword_inspected(sword : Sword) -> void : 
	_update_panel_style(sword)


func _on_sword_lock_updated(sword : Sword) -> void : 
	if sword == _sword : 
		_update_lock()
