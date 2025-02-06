extends HBoxContainer


func _on_toggle_buttons_toggled(toggled_on: bool) -> void:
	if toggled_on: show_buttons()
	if not toggled_on: hide_buttons()



func show_buttons() -> void:
	var slide_in = create_tween()
	slide_in.tween_property(self, "position:x", get_viewport_rect().size.x - self.size.x,0.2) \
	.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)

func hide_buttons() -> void:
	var slide_out = create_tween()
	slide_out.tween_property(self, "position:x", get_viewport_rect().size.x - (%ToggleButtons.size.x - 1),0.2) \
	.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
