extends TabContainer

@onready var sword_inventory_button: Button = %SwordInventoryButton
@onready var resource_inventory_button: Button = %ResourceInventoryButton
@onready var inventory_buttons_panel: HBoxContainer = %InventoryButtonsPanel




func _ready() -> void :
	(%SwordInventoryButton as Button).disabled = true
	(%SwordInventoryButton as Button).pressed.connect(_on_sword_button_pressed)
	(%ResourceInventoryButton as Button).pressed.connect(_on_ores_button_pressed)


func _on_sword_button_pressed() -> void : 
	SoundMachine.play_sound(2,1)
	current_tab = 0
	resource_inventory_button.button_pressed = false
	sword_inventory_button.disabled = true
	resource_inventory_button.disabled = false
	inventory_buttons_panel.visible = true


func _on_ores_button_pressed() -> void : 
	SoundMachine.play_sound(2,1)
	current_tab = 1
	sword_inventory_button.button_pressed = false
	resource_inventory_button.disabled = true
	sword_inventory_button.disabled = false
	inventory_buttons_panel.visible = false
