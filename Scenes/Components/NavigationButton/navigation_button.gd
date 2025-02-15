class_name NavigationButton extends Button


signal navigation_requested(target : UserInterface.Views)


@export var texture : Texture2D
@export var target : UserInterface.Views
@export var display_name : String = "SOMEWHERE"

var hovered : bool = false
var unfolded : bool = false
var colour_folded_modulate : Color = Color(0.33, 0.33, 0.33)
var colour_unfolded_modulate : Color = Color(1.0, 1.0, 1.0)


func _ready() -> void :
	(self as Button).pressed.connect(on_button_pressed)
	
	(%Label as Label).modulate.a = 0.0
	(%Texture as TextureRect).modulate = colour_folded_modulate
	(%Texture as TextureRect).texture = texture
	(%Label as Label).text = display_name



func fold() -> void :
	self.disabled = false
	var texture_tween : Tween = create_tween()
	texture_tween.tween_property(%Texture, "position:y", 0.0, 0.15).from(-8.0)
	texture_tween.set_parallel(true).\
	tween_property(%Texture, "modulate", colour_folded_modulate, 0.2).\
	from(colour_unfolded_modulate)
	
	var label_tween : Tween = create_tween()
	label_tween.tween_property(%Label, "modulate:a", 0.0, 0.15).from(1.0)
	
	unfolded = false


func unfold() -> void : 
	self.disabled = true
	var texture_tween : Tween = create_tween()
	texture_tween.tween_property(%Texture, "position:y", -8.0, 0.15).from(0.0)
	texture_tween.set_parallel(true).\
	tween_property(%Texture, "modulate", colour_unfolded_modulate, 0.2).\
	from(colour_folded_modulate)
	
	var label_tween : Tween = create_tween()
	label_tween.tween_property(%Label, "modulate:a", 1.0, 0.15).from(0.0)
	
	unfolded = true


func on_button_pressed() -> void : 
	navigation_requested.emit(target)
	SoundMachine.play_sound(1,1)
