extends VBoxContainer
##


##
func _ready() -> void :
	Crafting.ref.sword_crafted.connect(_on_sword_crafted)


##
func _update_labels(sword : Sword) -> void : 
	(%InfoName as Label).text = sword.name
	(%InfoForgeRate as Label).text = str(sword.forge_rate)
	(%InfoDamage as Label).text = str(sword.damage)


##
func _on_sword_crafted(sword : Sword) -> void : 
	_update_labels(sword)
