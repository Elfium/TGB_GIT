class_name NavigationButton extends Button


signal navigation_requested(target : UserInterface.Views)


@export var texture : Texture2D
@export var target : UserInterface.Views
@export var display_name : String = "SOMEWHERE"

var hovered : bool = false
var unfolded : bool = false


func _ready() -> void :
	(self as Button).pressed.connect(on_button_pressed)
	
	(%Texture as TextureRect).material = load("uid://dqkc4rsnddlye").duplicate()
	(%Texture as TextureRect).material.set_shader_parameter("saturation", 0.0)
	(%Texture as TextureRect).material.set_shader_parameter("brightness", 0.5)
	
	(%Label as Label).modulate.a = 0.0
	(%Texture as TextureRect).texture = texture
	(%Label as Label).text = display_name


func fold() -> void :
	(%Texture as TextureRect).material.set_shader_parameter("saturation", 0.0)
	(%Texture as TextureRect).material.set_shader_parameter("brightness", 0.5)
	
	var texture_tween : Tween = create_tween()
	texture_tween.tween_property(%Texture, "position:y", 3.0, 0.1).from(-8.0)
	
	var label_tween : Tween = create_tween()
	label_tween.tween_property(%Label, "modulate:a", 0.0, 0.1).from(1.0)
	
	unfolded = false
	self.disabled = false


func unfold() -> void : 
	(%Texture as TextureRect).material.set_shader_parameter("saturation", 1.0)
	(%Texture as TextureRect).material.set_shader_parameter("brightness", 1.0)
	
	var texture_tween : Tween = create_tween()
	texture_tween.tween_property(%Texture, "position:y", -8.0, 0.1).from(0.0)
	
	var label_tween : Tween = create_tween()
	label_tween.tween_property(%Label, "modulate:a", 1.0, 0.1).from(0.0)
	
	unfolded = true
	self.disabled = true


func on_button_pressed() -> void : 
	navigation_requested.emit(target)
	SoundMachine.play_sound(1,1)
