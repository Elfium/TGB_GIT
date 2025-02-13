class_name UiOreVeinLoot extends TextureRect
##


##
var ore : Ore
var quantity : int


func _ready() -> void :
	texture = ore.texture
	(%Label as Label).text = "%s" %quantity
	
	var tween : Tween = create_tween()
	await tween.tween_property(self, "modulate:a", 0.0, 1.5).set_trans(Tween.TRANS_EXPO).finished
	queue_free()


##
func inject_data(_ore : Ore, _quantity : int) -> void : 
	ore = _ore
	quantity = _quantity
