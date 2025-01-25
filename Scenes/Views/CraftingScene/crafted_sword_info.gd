extends VBoxContainer
##


##
func _ready() -> void :
	Crafting.ref.sword_crafted.connect(_on_sword_crafted)


##
func _update_labels(sword : Sword) -> void : 
	_update_name(sword)
	(%InfoForgeRate as Label).text = str(sword.forge_rate)
	(%InfoDamage as Label).text = str(sword.damage)


##
func _update_name(sword : Sword) -> void : 
	var text : String = ""
	
	if sword.forge_rate >= 600 : 
		text = sword.name
	elif sword.forge_rate >= 300 : 
		text = "Blue " + sword.name
		#TODO Label colour
	else : 
		text = "Red " + sword.name
		#TODO Label colour
	
	(%InfoName as Label).text = text


##
func _on_sword_crafted(sword : Sword) -> void : 
	_update_labels(sword)
	
