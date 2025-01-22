class_name Upgrade extends Resource
##


##
enum Enum {
	UNLOCK_TIER1_LEVEL2,
	UNLOCK_TIER1_LEVEL3,
}


##
var key : Enum
##
var name : String
##
var upgrade_effect : UpgradeEffect
##
var cost : int
##
var requirements : Array[Enum]
##
static var dictionary : Dictionary[Enum, Upgrade] 


##
func purchase() -> Error : 
	if Game.ref.data.upgrades[key] : return FAILED
	if not Currency.ref.can_consume(cost) : return FAILED
	for requirement : Enum in requirements : 
		if not Game.ref.data.upgrades[requirement] : return FAILED
	
	var error : Error = Currency.ref.consume(cost)
	if error : return FAILED
	
	print_rich("[color=green]Spent %s currency to buy the Upgrade %s[/color]" %[cost, name])
	
	Game.ref.data.upgrades[key] = true
	Signals.ref.upgrade_purchased.emit(self)
	
	upgrade_effect.apply_effect()
	
	return OK


##
static func initialise_upgrades() -> Error : 
	if dictionary.size() > 0 : return FAILED
	
	var upgrade : Upgrade = Upgrade.new()
	upgrade.key = Enum.UNLOCK_TIER1_LEVEL2
	upgrade.name = "Unlock the Almost BEST Recipe"
	upgrade.cost = 100
	upgrade.upgrade_effect = UpgradeEffect.new()
	upgrade.upgrade_effect.effect = UpgradeEffect.Effects.UNLOCK_RECIPE
	upgrade.upgrade_effect.values[UpgradeEffect.Values.RECIPE_KEY] = SwordRecipe.List.TIER_1_LEVEL_2
	upgrade.requirements = []
	dictionary[upgrade.key] = upgrade
	
	upgrade = Upgrade.new()
	upgrade.key = Enum.UNLOCK_TIER1_LEVEL3
	upgrade.name = "Unlock the BEST Recipe"
	upgrade.cost = 250
	upgrade.upgrade_effect = UpgradeEffect.new()
	upgrade.upgrade_effect.effect = UpgradeEffect.Effects.UNLOCK_RECIPE
	upgrade.upgrade_effect.values[UpgradeEffect.Values.RECIPE_KEY] = SwordRecipe.List.TIER_1_LEVEL_3
	upgrade.requirements = [Enum.UNLOCK_TIER1_LEVEL2]
	dictionary[upgrade.key] = upgrade
	
	_check_data()
	
	return OK


##
static func apply_upgrades() -> void : 
	for upgrade_key : Enum in Game.ref.data.upgrades.keys() : 
		if Game.ref.data.upgrades[upgrade_key] :
			dictionary[upgrade_key].upgrade_effect.apply_effect()


##
static func _check_data() -> void : 
	for upgrade : Enum in Enum.values() : 
		if not Game.ref.data.upgrades.has(upgrade) : 
			Game.ref.data.upgrades[upgrade] = false
