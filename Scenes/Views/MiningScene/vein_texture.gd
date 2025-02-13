extends TextureRect
##


##
#func _ready() -> void :
	#Mining.ref.ore_vein_changed.connect(_on_ore_vein_changed)


##
#func _on_ore_vein_changed(ore_vein : OreVein) -> void : 
	#texture = ore_vein.texture
