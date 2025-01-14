class_name DebugTestSwordDisplay extends Control
## Debug class tailored for a specific test.


##
func _ready() -> void :
	(%RandomiseButton as Button).pressed.connect(_on_randomise_button_pressed)
	_randomise_swords()


##
func _randomise_swords() -> void :
	($Sword as DebugTestSwordDisplayUnit).set_sword(SwordCraft.create_sword())
	($Sword2 as DebugTestSwordDisplayUnit).set_sword(SwordCraft.create_sword())


##
func _on_randomise_button_pressed() -> void : 
	_randomise_swords()
