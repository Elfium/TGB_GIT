class_name SwordTooltip extends VBoxContainer
## Displays a tooltip containing the basic informations of a Sword.


##
var sword : Sword 


##
func set_sword(_sword : Sword) -> Error : 
	if not _sword : return FAILED
	
	sword = _sword
	_reset_labels()
	
	return OK


##
func _reset_labels() -> void : 
	if not sword : return
	
	(%Header as Label).text = "%s" %sword.name
	
	(%Tier as Label).text = "Tier : %s" %sword.tier
	(%ForgeLevel as Label).text = "Forge Rate : %s" %sword.forge_rate
	(%Damage as Label).text = "Damage : %s" %sword.damage
