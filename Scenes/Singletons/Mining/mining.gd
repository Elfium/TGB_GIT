class_name Mining extends Node
## Singleton managing the mining process.

## Singleton ref.
static var ref : Mining 
## Singleton constructor.
func _init() -> void :
	if not ref : ref = self
	else : queue_free()


##
signal mining_started(duration : float)
##
signal mining_stopped
##
signal mining_progressed(value : float)
##
signal mining_cycle_completed(ore_vein : OreVein)
##
signal mining_ores_collected


##
var ore_vein : OreVein
##
var _is_mining : bool = false
##
var _progress : float = 0.0


##
func _ready() -> void :
	ore_vein = OreVein.get_ore_vein(OreVein.List.TIER_2)


##
func _process(delta: float) -> void :
	if _is_mining : 
		_progress_mining(delta)


##
func _progress_mining(delta : float) -> void : 
	_progress += delta
	mining_progressed.emit(_progress)
	if _progress >= ore_vein.duration : 
		_complete_cycle()


##
func _complete_cycle() -> void : 
	_progress = 0.0
	_process_loot()
	mining_cycle_completed.emit(ore_vein)


##
func _process_loot() -> void : 
	for loot : OreVein.Loot in ore_vein.content : 
		var roll : int = randi_range(1, 100)
		if roll <= loot.odd :
			_process_successful_loot(loot)


##
func _process_successful_loot(loot : OreVein.Loot) -> void : 
	var quantity : int = randi_range(loot.quantity.x, loot.quantity.y)
	if Game.ref.data.mining_ores_container.has(loot.ore.enum_value) : 
		Game.ref.data.mining_ores_container[loot.ore.enum_value] += quantity
	else : 
		Game.ref.data.mining_ores_container[loot.ore.enum_value] = quantity


##
func start_mining() -> void : 
	if _is_mining : return
	_is_mining = true
	_progress = 0.0
	mining_started.emit(ore_vein.duration)


##
func stop_mining() -> void :
	if not _is_mining : return
	_is_mining = false
	_progress = 0.0
	mining_stopped.emit()


##
func collect_ores() -> void : 
	var keys : Array[Variant] = Game.ref.data.mining_ores_container.keys()
	for key : Ore.List in keys : 
		OreManager.ref.create_ore(key, Game.ref.data.mining_ores_container[key])
		print("Collecting %sx %s. (New Value : %s)" %[
			Game.ref.data.mining_ores_container[key],
			Ore.get_ore(key).name,
			OreManager.ref.get_ore(key)
		])
	Game.ref.data.mining_ores_container.clear()
	mining_ores_collected.emit()
