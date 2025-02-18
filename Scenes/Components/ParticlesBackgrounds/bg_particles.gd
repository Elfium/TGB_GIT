extends Control

func _ready() -> void:
	(%Sparks_Back as CPUParticles2D).emission_rect_extents.x = get_viewport_rect().size.x / 2
	(%Sparks_Back as CPUParticles2D).position.x = get_viewport_rect().size.x / 2
	(%Sparks_Front as CPUParticles2D).emission_rect_extents.x = get_viewport_rect().size.x / 2
	(%Sparks_Front as CPUParticles2D).position.x = get_viewport_rect().size.x / 2
