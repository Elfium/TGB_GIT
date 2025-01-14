extends Node


func _ready() -> void :
	var sword : Sword = SwordCraft.create_sword()
	sword.debug_print_stats()
