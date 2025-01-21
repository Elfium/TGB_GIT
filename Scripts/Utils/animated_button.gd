class_name AnimatedButton extends Button


func _ready() -> void :
	pressed.connect(_on_pressed)
	_reposition_pivot_offset()


func _reposition_pivot_offset() -> void : 
	pivot_offset = size / 2.0


func _on_pressed() -> void :
	Anims.button_click(self)
