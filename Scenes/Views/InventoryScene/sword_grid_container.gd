extends GridContainer
##


##
func _ready() -> void :
	Inventory.ref.sword_added.connect(_on_sword_added)
	Inventory.ref.sword_removed.connect(_on_sword_removed)


##
func _instantiate_sword(sword : Sword) -> void : 
	pass


##
func _on_sword_added(sword : Sword) -> void : 
	pass


##
func _on_sword_removed(sword : Sword) -> void : 
	pass
