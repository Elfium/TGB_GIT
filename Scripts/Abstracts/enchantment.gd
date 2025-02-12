class_name Enchantment extends Resource


enum Enum {
	FORGE_RATE,
	DAMAGE,
}

@export var key : Enum = Enum.FORGE_RATE
@export var value : float = 0.0


func get_shader() -> ShaderMaterial : 
	match key : 
		Enum.FORGE_RATE : return load("uid://ceilpucafqw0q")
		Enum.DAMAGE : return load("uid://cjw75rsg1m1nj")
		_ : return load("uid://ceilpucafqw0q")
