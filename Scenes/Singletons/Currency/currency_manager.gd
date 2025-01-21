class_name Currency extends Node
##

##
static var ref : Currency
##
func _init() -> void :
	if not ref : ref = self
	else : queue_free()


##
signal currency_created(quantity : int)
##
signal currency_consumed(quantity : int)
##
signal currency_updated


##
func create(quantity : int) -> Error : 
	if quantity <= 0 : return FAILED
	
	Game.ref.data.currency += quantity
	currency_created.emit(quantity)
	currency_updated.emit()
	print_rich("[color=ff18a6]You currently have %s currency.[/color]"%Game.ref.data.currency)
	
	return OK


##
func consume(quantity : int, forced : bool = false) -> Error : 
	if quantity < 0 : return FAILED
	if quantity > Game.ref.data.currency and not forced : return FAILED
	
	Game.ref.data.currency -= quantity
	if Game.ref.data.currency <= 0 : Game.ref.data.currency = 0
	
	currency_consumed.emit(quantity)
	currency_updated.emit()
	
	return OK


##
func can_consume(quantity : int) -> bool : 
	if quantity < 0 : return false 
	if quantity > Game.ref.data.currency : return false
	
	return true


##
func get_value() -> int : 
	return Game.ref.data.currency
