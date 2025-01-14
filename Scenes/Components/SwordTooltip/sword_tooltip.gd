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
	
	(%Header as Label).text = "Sword"
	
	(%Tier as Label).text = "Tier : %s" %sword.tier
	(%ForgeLevel as Label).text = "Forge level : %s" %sword.forge_level
	(%Damage as Label).text = "Damage : %0.1f" %sword.damage
