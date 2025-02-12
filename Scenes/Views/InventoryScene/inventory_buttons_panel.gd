class_name InventoryRightMenu extends HBoxContainer


var toggled : bool = false


func on_toggle_buttons_pressed() -> void:
	if toggled : hide_buttons()
	else : show_buttons()


func show_buttons() -> void:
	if toggled : return
	var slide_in = create_tween()
	slide_in.tween_property(self, "position:x", get_viewport_rect().size.x - self.size.x,0.2) \
	.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	toggled = true

func hide_buttons() -> void:
	if not toggled : return
	var slide_out = create_tween()
	slide_out.tween_property(self, "position:x", get_viewport_rect().size.x - (%ToggleButtons.size.x - 1),0.2) \
	.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	toggled = false
