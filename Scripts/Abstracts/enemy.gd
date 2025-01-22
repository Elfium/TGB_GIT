class_name Enemy extends Resource
##


##
enum Enum {
	ZOMBIE,
	SKELETON,
}


##
@export var key : Enum
##
@export var name : String
##
@export var health : int 
##
@export var current_health : int
##
@export var damage : Vector2i


##
static var dictionary : Dictionary[Enum, Enemy]


##
static func initialise_dictionary() -> Error : 
	if dictionary.size() > 0 : return FAILED
	
	var enemy : Enemy
	
	enemy = Enemy.new()
	enemy.key = Enum.ZOMBIE
	enemy.name = "Zombie"
	enemy.health = 10
	enemy.current_health = 10
	enemy.damage = Vector2i(2, 5)
	dictionary[enemy.key] = enemy
	
	enemy = Enemy.new()
	enemy.key = Enum.SKELETON
	enemy.name = "Skeleton"
	enemy.health = 5
	enemy.current_health = 5
	enemy.damage = Vector2i(5, 10)
	dictionary[enemy.key] = enemy
	
	return OK
