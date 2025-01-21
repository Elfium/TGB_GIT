class_name UICrafting extends Control
##


##
@onready var _blueprint_texture : TextureRect = %Sword_Blueprint_Texture
##
@onready var _crafted_sword_control : Control = %Crafted_Sword
##
@onready var _crafting_process_panel : Panel = %Crafting_Process_Panel
##
@onready var _shine : TextureRect = %Shine
##
@onready var _sword_info_animation : AnimationPlayer = %BG_Animation


##
func _enter_tree() -> void :
	Crafting.ref.collect_sword()


##
func _ready() -> void :
	(%Collect_Button as Button).pressed.connect(_on_collect_button_pressed)
	Crafting.ref.sword_crafted.connect(_on_sword_crafted)
	Crafting.ref.sword_collected.connect(_on_sword_collected)
	_update_sword()
	


##
func _update_sword() -> void : 
	if Game.ref.data.crafted_sword : 
		_blueprint_texture.visible = false
		_crafted_sword_control.visible = true 
		_crafting_process_panel.visible = true
		_shine.visible = true 
		_update_textures(Game.ref.data.crafted_sword)
	else : 
		_blueprint_texture.visible = true
		_crafted_sword_control.visible = false 
		_crafting_process_panel.visible = false
		_shine.visible = false 


##
func _toggle_craft_info(toggle : bool = true) -> void :
	if toggle :
		_sword_info_animation.play("bg")
		var process_panel_tween_out = create_tween()
		process_panel_tween_out.tween_property(%Crafting_Process_Panel as Panel, "modulate:a", 0, 0.3).from(1)
	else : _sword_info_animation.play("RESET")


##
func _update_textures(sword : Sword) -> void : 
	(%Craft_Blade_Texture as TextureRect).texture = sword.get_blade_part().texture
	(%Craft_Handle_Texture as TextureRect).texture = sword.get_handle_part().texture
	(%Craft_Pommel_Texture as TextureRect).texture = sword.get_pommel_part().texture
	(%Craft_Guard_Texture as TextureRect).texture = sword.get_guard_part().texture


##
func _on_collect_button_pressed() -> void : 
	Anims.button_click(%Collect_Button as Button)
	%Button_Press_Sound.play()
	Crafting.ref.collect_sword()
	_toggle_craft_info(false)


## 
func _on_sword_crafted(sword : Sword) -> void : 
	%Process_Animation.play("RESET")
	%Process_Animation.speed_scale = 1.0
	_update_sword()
	var preparation_tween = create_tween()
	var process_panel_tween_in = create_tween()
	process_panel_tween_in.tween_property(%Crafting_Process_Panel as Panel, "modulate:a", 1.0, 0.3).from(0.0)
	await preparation_tween.tween_property(%Preparation_Bar as ProgressBar, "value", 100, 1.0).from(0.0).finished
	
	if sword.is_masterwork() : 
		##Add the masterwork animation here.
		%Process_Animation.play("Crafting")
		print_rich("[color=ff18a6]THIS WAS A MASTERWORK ![/color]")
	else : 
		%Process_Animation.play("Crafting")


##
func normalize_crafting_speed() -> void:
	%Process_Animation.speed_scale = 1.0


##
func _on_sword_collected(_sword : Sword) -> void : 
	_update_sword()
	_toggle_craft_info(false)
