class_name Data extends Resource
##


##
@export var currency : int = 0
##
@export var stats : DataStats = DataStats.new()
##
@export var ores : Dictionary = {
	Ore.List.TIER_1 : 0,
	Ore.List.TIER_2 : 0,
	Ore.List.TIER_3 : 0,
}
## 
@export var mining_ores_container : Dictionary = {}
##
@export var crafted_sword : Sword = null
##
@export var swords : Array[Sword] = []
##
@export var sword_recipes_unlock : Dictionary[SwordRecipe.List, bool] = {
	SwordRecipe.List.TIER_1_LEVEL_1 : true,
	SwordRecipe.List.TIER_1_LEVEL_2 : false,
	SwordRecipe.List.TIER_1_LEVEL_3 : false,
}
##
@export var upgrades : Dictionary[Upgrade.Enum, bool]
##
@export var combat : DataCombat = DataCombat.new()
