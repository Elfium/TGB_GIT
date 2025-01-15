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
@export var blade_part : SwordPart
##
@export var handle_part : SwordPart
##
@export var pommel_part : SwordPart
##
@export var guard_part : SwordPart


##
func debug_print_stats() -> void : 
	print("Tier %s Sword :" %tier)
	print("Forge rate : %s" %forge_rate)
	print("Damage : %0.1f" %damage)
	print("===============")


##
static func create_sword(recipe : SwordRecipe) -> Sword : 
	var sword : Sword = Sword.new()
	
	sword.tier = recipe.tier
	sword.name = recipe.name
	
	sword.blade_part = recipe.blade_parts.pick_random()
	sword.handle_part = recipe.handle_parts.pick_random()
	sword.pommel_part = recipe.pommel_parts.pick_random()
	sword.guard_part = recipe.guard_parts.pick_random()
	
	sword.forge_rate += sword.blade_part.forge_rate
	sword.forge_rate += sword.handle_part.forge_rate
	sword.forge_rate += sword.pommel_part.forge_rate
	sword.forge_rate += sword.guard_part.forge_rate
	
	sword.damage = round(pow(sword.forge_rate, 1.0/3.0))
	
	return sword
