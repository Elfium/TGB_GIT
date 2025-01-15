class_name UICrafting extends Control
##


##
@onready var _blueprint_texture : TextureRect = %Sword_Blueprint_Texture
##
@onready var _crafted_sword_control : Control = %Crafted_Sword
##
@onready var _crafting_process_panel: Panel = %Crafting_Process_Panel



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
		_update_textures(Game.ref.data.crafted_sword.get_textures())
	else : 
		_blueprint_texture.visible = true
		_crafted_sword_control.visible = false 
		_crafting_process_panel.visible = false


##
func _update_textures(textures : Array[Texture2D]) -> void : 
	(%Craft_Blade_Texture as TextureRect).texture = textures[0]
	(%Craft_Handle_Texture as TextureRect).texture = textures[1]
	(%Craft_Pommel_Texture as TextureRect).texture = textures[2]
	(%Craft_Guard_Texture as TextureRect).texture = textures[3]


func _on_collect_button_pressed() -> void : 
	Anims.button_click(%Collect_Button as Button)
	%Button_Press_Sound.play()
	await get_tree().create_timer(0.1).timeout
	Crafting.ref.collect_sword()


## 
func _on_sword_crafted(_sword : Sword) -> void : 
	%Process_Animation.stop()
	%Process_Animation.play("Process_Short")
	_update_sword()


##
func _on_sword_collected(_sword : Sword) -> void : 
	_update_sword()
