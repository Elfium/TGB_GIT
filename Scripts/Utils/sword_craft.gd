class_name SwordCraft
## A util Class used to craft Swords. 
##
## Currently uses dummy properties to generate tier 1 swords.
## \nDamages are calculated based on forge_level ^ 1/3.
## \nThe repartition of forge_level is linear.


##
static var craft_power : int = 250


##
static func create_sword(tier : int = 1) -> Sword : 
	match tier : 
		_, 1 : return create_tier_1_sword()


##
static func create_tier_1_sword() -> Sword :
	var sword : Sword = Sword.new()
	
	sword.tier = 1
	sword.forge_level = randi_range(craft_power, 1000)
	sword.damage = pow(sword.forge_level, 1.0/3.0)
	
	randomise_parts(sword)
	
	return sword

##
static func randomise_parts(sword : Sword) -> Error : 
	sword.blade_part = Sword.BladeParts.values().pick_random()
	sword.handle_part = Sword.HandleParts.values().pick_random()
	sword.pommel_part = Sword.PommelParts.values().pick_random()
	sword.guard_part = Sword.GuardParts.values().pick_random()
	
	return OK
