extends Button
##


##
func _ready() -> void: 
	Crafting.ref.sword_crafted.connect(_on_sword_crafted)
	Crafting.ref.sword_collected.connect(_on_sword_collected)
	visible = true if Game.ref.data.crafted_sword else false


##
func _on_sword_crafted(_sword : Sword) -> void : 
	visible = true


##
func _on_sword_collected(_sword : Sword) -> void : 
	visible = false
