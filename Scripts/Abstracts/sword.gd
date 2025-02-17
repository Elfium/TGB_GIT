class_name Sword extends Resource
## Resource script describing a Sword. 


enum Weight_Class {
	LIGHT,
	MEDIUM,
	HEAVY,
}


enum Sword_Type {
	SLASH,
	THRUST,
	HYBRID,
}


##
@export var name : String = "Unnamed Sword"
## 
@export var tier : int = 1
##
@export var level : int = 1
##
@export var weight : int = 0
##
@export var weight_class : Weight_Class = Weight_Class.HEAVY
##
@export var damage : float = 1.0
##
@export var sword_type : Sword_Type = Sword_Type.HYBRID
##
@export var attack_speed : float = 0.5
##
@export var forge_rate : int = 0
##
@export var locked : bool = false

##
@export var blade_part : int
##
@export var handle_part : int
##
@export var pommel_part : int
##
@export var guard_part : int

@export var enchantment : Enchantment = null


##
func is_masterwork() -> bool : 
	if SwordPart.sword_parts[blade_part].level < 3 : return false 
	if SwordPart.sword_parts[handle_part].level < 3 : return false
	if SwordPart.sword_parts[pommel_part].level < 3 : return false
	if SwordPart.sword_parts[guard_part].level < 3 : return false
	return true


##
func get_currency_value() -> int : 
	return int(damage)


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
func initialise_name() -> void : 
	var text : String = ""
	
	if forge_rate >= 600 : 
		text = name
	elif forge_rate >= 300 : 
		text = "Blue " + name
	else : 
		text = "Red " + name
	
	name = text


func calculate_damage() -> void :
	damage = round(pow(forge_rate, 0.8/1.4))


func calculate_weight() -> void :
	weight = 0
	weight += get_blade_part().weight
	weight += get_pommel_part().weight
	weight += get_handle_part().weight
	weight += get_guard_part().weight
	
	if weight < 25 : weight_class = Weight_Class.LIGHT
	elif weight < 50 : weight_class = Weight_Class.MEDIUM
	else : weight_class = Weight_Class.HEAVY
	
	print("Sword weight : %s" %weight)
	print("Weight Class : %s" %get_weight_class())


func get_weight_class() -> String : 
	match weight_class : 
		Weight_Class.LIGHT : return "Light"
		Weight_Class.MEDIUM : return "Medium"
		Weight_Class.HEAVY : return "Heavy"
		_ : return "Error"


func get_sword_type() -> String :
	match sword_type : 
		Sword_Type.SLASH : return "Slash"
		Sword_Type.THRUST : return "Thrust"
		_, Sword_Type.HYBRID : return "Hybrid"


func calculate_attack_speed() -> void :
	@warning_ignore("integer_division")
	var count : int = int(weight / 5)
	var factor : float 
	match weight_class : 
		Weight_Class.LIGHT : factor = 0.04
		Weight_Class.MEDIUM : factor = 0.05
		_, Weight_Class.HEAVY : factor = 0.06
	attack_speed = count * factor
	print("Sword attack speed : %0.1f" %attack_speed)


func enchant(new_enchantment : Enchantment) -> void : 
	if enchantment != null : return
	
	enchantment = new_enchantment
	
	##TODO Create an Enchantment Manager.
	
	if enchantment.key == Enchantment.Enum.FORGE_RATE : 
		forge_rate += int(enchantment.value)
		calculate_damage()
	if enchantment.key == Enchantment.Enum.DAMAGE : 
		damage += enchantment.value


##
static func get_random_part(parts : Array[SwordPart]) -> SwordPart : 
	var total_weight : int = 0 
	
	for part : SwordPart in parts : 
		total_weight += part.drop_weight
	
	var roll : int = randi_range(0, total_weight - 1)
	
	for part : SwordPart in parts :
		if roll < part.drop_weight : return part
		else  : roll -= part.drop_weight
	
	return null


##
static func create_sword(recipe : SwordRecipe) -> Sword : 
	var sword : Sword = Sword.new()
	
	sword.tier = recipe.tier
	sword.level = recipe.level
	sword.name = recipe.name
	
	sword.blade_part = get_random_part(recipe.blade_parts).key
	sword.handle_part = get_random_part(recipe.handle_parts).key
	sword.pommel_part = get_random_part(recipe.pommel_parts).key
	sword.guard_part = get_random_part(recipe.guard_parts).key
	
	var blade_forge_rate : Vector2i = SwordPart.sword_parts[sword.blade_part].forge_rate
	var handle_forge_rate : Vector2i =  SwordPart.sword_parts[sword.handle_part].forge_rate
	var pommel_forge_rate : Vector2i = SwordPart.sword_parts[sword.pommel_part].forge_rate
	var guard_forge_rate : Vector2i = SwordPart.sword_parts[sword.guard_part].forge_rate
	
	sword.forge_rate += snappedi(randi_range(blade_forge_rate.x, blade_forge_rate.y), 5)
	sword.forge_rate += snappedi(randi_range(handle_forge_rate.x, handle_forge_rate.y), 5)
	sword.forge_rate += snappedi(randi_range(pommel_forge_rate.x, pommel_forge_rate.y), 5)
	sword.forge_rate += snappedi(randi_range(guard_forge_rate.x, guard_forge_rate.y), 5)
	
	sword.sword_type = sword.get_blade_part().sword_type
	print("Sword type : %s" %sword.get_sword_type())
	
	sword.calculate_damage()
	sword.calculate_weight()
	sword.calculate_attack_speed()
	
	sword.initialise_name()
	
	#var new_enchantment : Enchantment = Enchantment.new()
	#new_enchantment.key = Enchantment.Enum.DAMAGE
	#new_enchantment.value = randi_range(5, 10)
	#sword.enchant(new_enchantment)
	
	Game.ref.data.stats.swords_crafted += 1 
	if sword.is_masterwork() : Game.ref.data.stats.masterwork_crafts += 1
	Game.ref.data.stats.highest_forge_rate_craft = max(Game.ref.data.stats.highest_forge_rate_craft, sword.forge_rate)
	Game.ref.data.stats.total_craft_value += sword.get_currency_value()
	
	Experience.ref.get_sword_experience(sword)
	
	return sword
