class_name MainTabContainer extends TabContainer
##


##
func _input(event : InputEvent) -> void :
	if event.is_action_pressed("navigate_to_mining") : current_tab = 0
	if event.is_action_pressed("navigate_to_crafting") : current_tab = 1
	if event.is_action_pressed("navigate_to_inventory") : current_tab = 2
