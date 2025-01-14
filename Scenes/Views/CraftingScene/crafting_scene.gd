class_name UICrafting extends Control
##


##
@onready var _blueprint_texture : TextureRect = %Sword_Blueprint_Texture
##
@onready var _crafted_sword_control : Control = %Crafted_Sword


##
func _ready() -> void :
	(%Collect_Button as Button).pressed.connect(_on_collect_button_pressed)
	#(%Craft_Tier_1_Sword as Button).pressed.connect(_on_craft_tier_1_sword_button_pressed)
	Crafting.ref.sword_crafted.connect(_on_sword_crafted)
	Crafting.ref.sword_collected.connect(_on_sword_collected)
	_blueprint_texture.visible = true
	_crafted_sword_control.visible = false 


##
func _update_sword() -> void : 
	if Game.ref.data.crafted_sword : 
		_blueprint_texture.visible = false
		_crafted_sword_control.visible = true 
		_update_textures(Game.ref.data.crafted_sword.get_textures())
	else : 
		_blueprint_texture.visible = true
		_crafted_sword_control.visible = false 


##
func _update_textures(textures : Array[Texture2D]) -> void : 
	(%Craft_Blade_Texture as TextureRect).texture = textures[0]
	(%Craft_Handle_Texture as TextureRect).texture = textures[1]
	(%Craft_Pommel_Texture as TextureRect).texture = textures[2]
	(%Craft_Guard_Texture as TextureRect).texture = textures[3]


## DEPRECATED
func _on_craft_tier_1_sword_button_pressed() -> void : 
	##Crafting.ref.craft_sword(1)
	pass


func _on_collect_button_pressed() -> void : 
	Crafting.ref.collect_sword()


##
func _on_sword_crafted(_sword : Sword) -> void : 
	_update_sword()


##
func _on_sword_collected(_sword : Sword) -> void : 
	_update_sword()
