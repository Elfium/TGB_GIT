class_name UserInterface extends VBoxContainer


enum Views {
	NONE = -1,
	MINING = 0,
	CRAFTING = 1,
	INVENTORY = 2,
}


var current_view : Views = Views.NONE
var buttons : Dictionary[Views, NavigationButton]


func _ready() -> void :
	initialise_buttons()


func initialise_buttons() -> void :
	for node : Node in %Buttons.get_children() : 
		if node is NavigationButton :
			buttons[node.target] = node
			node.navigation_requested.connect(on_navigation_requested)


func update_tab_container() -> void :
	(%MainTabContainer as TabContainer).current_tab = int(current_view)


func on_navigation_requested(target : Views) -> void : 
	if current_view != target : 
		if current_view != Views.NONE : buttons[current_view].fold()
		buttons[target].unfold()
		current_view = target
		update_tab_container()
