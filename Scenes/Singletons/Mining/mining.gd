class_name Mining extends Node
## Singleton managing the mining process.

## Singleton ref.
static var ref : Mining 
## Singleton constructor.
func _init() -> void :
	if not ref : ref = self
	else : queue_free()


##
signal ore_vein_changed(ore_vein : OreVein)
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
var mining_power : float = 2.5


##
func _ready() -> void :
	(%Timer as Timer).timeout.connect(_on_timer_timeout)
	ore_vein = OreVein.get_ore_vein(OreVein.List.TIER_2)


##
func set_vein(_ore_vein : OreVein) -> void : 
	if _is_mining : return
	if _ore_vein == ore_vein : return
	stop_mining()
	ore_vein = _ore_vein
	(%Timer as Timer).wait_time = ore_vein.duration
	ore_vein_changed.emit(ore_vein)


##
func _progress_mining() -> void : 
	_progress += mining_power
	mining_progressed.emit(_progress)
	if _progress >= ore_vein.progress_requirement : 
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
func toggle_mining() -> void : 
	if _is_mining : stop_mining()
	else : start_mining()


##
func start_mining() -> void : 
	if _is_mining : return
	_is_mining = true
	_progress = 0.0
	(%Timer as Timer).start()
	mining_started.emit(ore_vein.progress_requirement)


##
func stop_mining() -> void :
	if not _is_mining : return
	_is_mining = false
	_progress = 0.0
	(%Timer as Timer).stop()
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


func _on_timer_timeout() -> void : 
	_progress_mining()
