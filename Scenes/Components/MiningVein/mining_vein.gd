class_name OreVeinUi extends PanelContainer


static var loot_packed_scene : PackedScene = load("uid://d2ns5tgqru0qf")

var ore_vein : OreVein
var progress_bar : ProgressBar 


func _ready() -> void :
	(%ToggleButton as Button).pressed.connect(on_toggle_button_pressed)
	
	Mining.ref.mining_progressed.connect(on_mining_progressed)
	Mining.ref.mining_started.connect(on_mining_started)
	Mining.ref.mining_stopped.connect(on_mining_stopped)
	Mining.ref.loot_created.connect(on_loot_created)
	
	progress_bar = %ProgressBar
	
	initialise_nodes()


func inject_data(_ore_vein : OreVein) -> void : 
	ore_vein = _ore_vein


func initialise_nodes() -> void :
	if not ore_vein : return
	
	(%Texture as TextureRect).texture = ore_vein.texture
	(%Name as Label).text = ore_vein.name
	(%ProgressBar as ProgressBar).max_value = ore_vein.progress_requirement


func on_toggle_button_pressed() -> void : 
	Mining.ref.toggle_ore_vein(ore_vein)


func on_mining_started(_ore_vein : OreVein) -> void : 
	if not _ore_vein == ore_vein : return
	progress_bar.max_value = ore_vein.progress_requirement
	progress_bar.value = 0.0


func on_mining_progressed(_ore_vein : OreVein, value : float) -> void : 
	if not _ore_vein == ore_vein : return
	progress_bar.value = value


func on_mining_stopped(_ore_vein : OreVein) -> void : 
	if not _ore_vein == ore_vein : return
	progress_bar.value = 0.0


func on_loot_created(_ore_vein : OreVein, loot : OreVein.Loot, quantity : int) -> void : 
	if ore_vein != _ore_vein : return
	for index : int in range(quantity) : 
		var node : UiOreVeinLoot = loot_packed_scene.instantiate()
		node.inject_data(loot.ore, quantity)
		(%LootContainer as Node).add_child(node)
