class_name InventoryLeftMenu extends HBoxContainer

var width : float 
var toggled : bool = false


func _ready() -> void :
	Inventory.ref.sword_inspected.connect(on_sword_inspected)
	
	width = size.x
	position.x = -width


func on_toggle_buttons_pressed() -> void:
	if toggled : fold()
	else : unfold()


func unfold() -> void:
	if toggled : return
	var slide_in = create_tween()
	slide_in.tween_property(self, "position:x", 0, 0.2) \
	.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	toggled = true


func fold() -> void:
	if not toggled : return
	var slide_out = create_tween()
	slide_out.tween_property(self, "position:x", -width, 0.2) \
	.set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	toggled = false


func on_sword_inspected(sword : Sword) -> void : 
	(%InfoForgeRate as Label).text = str(sword.forge_rate)
	(%InfoDamage as Label).text = str(sword.damage)
	(%CurrencyValue as Label).text = str(sword.get_currency_value())
