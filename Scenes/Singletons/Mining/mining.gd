class_name Mining extends Node
## Singleton managing the mining process.

## Singleton ref.
static var ref : Mining 
## Singleton constructor.
func _init() -> void :
	if not ref : ref = self
	else : queue_free()


##
signal mining_started(ore_vein: OreVein)
##
signal mining_stopped(ore_vein : OreVein)
##
signal mining_progressed(ore_vein : OreVein, value : float)
##
signal mining_cycle_completed(ore_vein : OreVein)
##
signal loot_created(ore_vein : OreVein, loot : OreVein.Loot, quantity : int)


var mining_power : float = 2.5
var ore_veins : Dictionary[OreVein, float]
var max_parallel_mining : int = 2


##
func _ready() -> void :
	(%Timer as Timer).timeout.connect(on_timer_timeout)
	
	initialise_veins()


func initialise_veins() -> void : 
	for ore_vein : OreVein in OreVein.ore_veins : 
		ore_veins[ore_vein] = 0.0


##
func progress_mining() -> void : 
	for ore_vein : OreVein in ore_veins.keys() :
		if ore_vein.active : 
			ore_veins[ore_vein] += mining_power
			mining_progressed.emit(ore_vein, ore_veins[ore_vein])
			if ore_veins[ore_vein] >= ore_vein.progress_requirement : 
				complete_cycle(ore_vein)


##
func complete_cycle(ore_vein : OreVein) -> void : 
	ore_veins[ore_vein] = 0.0
	process_loot(ore_vein)
	mining_cycle_completed.emit(ore_vein)


func process_loot(ore_vein : OreVein) -> void : 
	for loot : OreVein.Loot in ore_vein.content : 
		var roll : int = randi_range(1, 100)
		if roll <= loot.odd :
			process_successful_loot(ore_vein, loot)


func process_successful_loot(ore_vein : OreVein, loot : OreVein.Loot) -> void : 
	var quantity : int = randi_range(loot.quantity.x, loot.quantity.y)
	OreManager.ref.create_ore(loot.ore.enum_value, quantity)
	loot_created.emit(ore_vein, loot, quantity)


func toggle_ore_vein(ore_vein : OreVein) -> void : 
	if ore_vein.active: 
		ore_vein.active = false 
	elif count_parallel_mining() < max_parallel_mining : 
		ore_vein.active = true


func count_parallel_mining() -> int : 
	var count : int = 0
	
	for ore_vein : OreVein in ore_veins : 
		if ore_vein.active : count += 1
	
	return count


func on_timer_timeout() -> void : 
	progress_mining()
