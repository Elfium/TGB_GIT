class_name TestManager extends Node
##


##
func _ready() -> void :
	_initialise_databases()
	_run_tests()


##
func _initialise_databases() -> void : 
	SwordPart.initialise_sword_parts()
	Ore.initialise_ores()
	OreVein.initialise_ore_veins()
	SwordRecipe.initialise_recipes()


##
func _run_tests() -> void : 
	await _run_test("uid://bl2iqfj1sle8b").tests_completed


##
func _run_test(test_uid : String) -> Test : 
	var node : Test = load(test_uid).instantiate()
	add_child(node)
	return node
