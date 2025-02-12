extends Node




func button_click(object : Variant, \
					can_scale : bool = false,
					can_shake : bool = false,
					modu_color : Color = Color(1,1,1) 
					) -> void:
	
	
	
	if can_scale:
		var scale = create_tween()
		scale.tween_property(object, "scale", Vector2(1,1), 0.1).from(Vector2(0.8,0.8))
	
	
	
	if can_shake:
		var shake = create_tween()
		#shake.tween_property(object,"rotation_degrees",7,0.05)
		shake.tween_property(object,"rotation_degrees",-5,0.05).from(7)
		shake.tween_property(object,"rotation_degrees",0,0.05)
	
	
	
	var modu = create_tween()
	modu.tween_property(object,"modulate", Color(1,1,1),0.2).from(modu_color)
