class_name Signals extends Node
##

##
static var ref : Signals
##
func _init() -> void : 
	if not ref : ref = self
	else : queue_free()


##
signal recipes_updated
