extends Node


func button_click(object) -> void:
	var scale = create_tween()
	scale.tween_property(object, "scale", Vector2(1,1), 0.1).from(Vector2(0.8,0.8))
	
	var shake = create_tween()
	shake.tween_property(object,"rotation_degrees",7,0.05)
	shake.tween_property(object,"rotation_degrees",-5,0.05)
	shake.tween_property(object,"rotation_degrees",0,0.05)
	
	var modu = create_tween()
	modu.tween_property(object,"modulate", Color(1,1,1),0.2).from(Color(4,3,2))
