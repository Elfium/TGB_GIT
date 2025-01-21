extends TabContainer


func _ready() -> void :
	(%SwordInventoryButton as Button).pressed.connect(_on_sword_button_pressed)
	(%ResourceInventoryButton as Button).pressed.connect(_on_ores_button_pressed)


func _on_sword_button_pressed() -> void : 
	current_tab = 0


func _on_ores_button_pressed() -> void : 
	current_tab = 1
