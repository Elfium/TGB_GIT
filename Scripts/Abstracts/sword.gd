class_name Sword extends Resource
## Resource script describing a Sword. 


##
@export var name : String = "Unnamed Sword"
## 
@export var tier : int = 1
##
@export var damage : float = 1.0
##
@export var forge_rate : int = 0

##
@export var blade_part : int
##
@export var handle_part : int
##
@export var pommel_part : int
##
@export var guard_part : int


##
func debug_print_stats() -> void : 
	print("Tier %s Sword :" %tier)
	print("Forge rate : %s" %forge_rate)
	print("Damage : %0.1f" %damage)
	print("===============")


##
func get_blade_part() -> SwordPart :
	return SwordPart.sword_parts[blade_part]


##
func get_handle_part() -> SwordPart :
	return SwordPart.sword_parts[handle_part]


##
func get_pommel_part() -> SwordPart :
	return SwordPart.sword_parts[pommel_part]


##
func get_guard_part() -> SwordPart :
	return SwordPart.sword_parts[guard_part]


##
static func create_sword(recipe : SwordRecipe) -> Sword : 
	var sword : Sword = Sword.new()
	
	sword.tier = recipe.tier
	sword.name = recipe.name
	
	sword.blade_part = recipe.blade_parts.pick_random().key
	sword.handle_part = recipe.handle_parts.pick_random().key
	sword.pommel_part = recipe.pommel_parts.pick_random().key
	sword.guard_part = recipe.guard_parts.pick_random().key
	
	sword.forge_rate += SwordPart.sword_parts[sword.blade_part].forge_rate
	sword.forge_rate += SwordPart.sword_parts[sword.handle_part].forge_rate
	sword.forge_rate += SwordPart.sword_parts[sword.pommel_part].forge_rate
	sword.forge_rate += SwordPart.sword_parts[sword.guard_part].forge_rate

	sword.damage = round(pow(sword.forge_rate, 1.0/3.0))
	
	return sword
