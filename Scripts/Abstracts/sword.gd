class_name Sword extends Resource
## Resource script describing a Sword. 


##
enum BladeParts {
	TYPE_A,
	TYPE_B,
	TYPE_C,
}

##
enum HandleParts {
	TYPE_A,
	TYPE_B,
}

##
enum PommelParts {
	TYPE_A,
	TYPE_B,
}

##
enum GuardParts {
	TYPE_A,
	TYPE_B,
}


##
@export var name : String = "Unnamed Sword"
## 
@export var tier : int = 1
##
@export var damage : float = 1.0
##
@export var forge_level : int = 1

##
@export var blade_part : BladeParts = BladeParts.TYPE_A
##
@export var handle_part : HandleParts = HandleParts.TYPE_A
##
@export var pommel_part : PommelParts = PommelParts.TYPE_A
##
@export var guard_part : GuardParts = GuardParts.TYPE_A


##
func debug_print_stats() -> void : 
	print("Tier %s Sword :" %tier)
	print("Forge level : %s" %forge_level)
	print("Damage : %0.1f" %damage)
	print("===============")
	print("Blade part : %s" %blade_part)
	print("Handle part : %s" %handle_part)
	print("Pommer part : %s" %pommel_part)
	print("Guard part : %s" %guard_part)


## Return textures with the following order : blade, handle, pommel, guard.
func get_textures() -> Array[Texture2D] : 
	var textures : Array[Texture2D] = [null, null, null, null]
	
	match blade_part : 
		BladeParts.TYPE_A : textures[0] = load("res://Assets/Swords/Blade/Blade_1.png")
		BladeParts.TYPE_B : textures[0] = load("res://Assets/Swords/Blade/Blade_3.png")
		_, BladeParts.TYPE_C : textures[0] = load("res://Assets/Swords/Blade/Blade_4.png")
	
	match handle_part :
		HandleParts.TYPE_A : textures[1] = load("res://Assets/Swords/Handle/Handle_1.png")
		_, HandleParts.TYPE_B : textures[1] = load("res://Assets/Swords/Handle/Handle_2.png")
	
	match pommel_part : 
		PommelParts.TYPE_A : textures[2] = load("res://Assets/Swords/Pommel/Pommel_1.png")
		PommelParts.TYPE_B : textures[2] = load("res://Assets/Swords/Pommel/Pommel_2.png")
	
	match guard_part : 
		GuardParts.TYPE_A : textures[3] = load("res://Assets/Swords/Guard/Guard_1.png")
		GuardParts.TYPE_B : textures[3] = load("res://Assets/Swords/Guard/Guard_2.png")
	
	return textures
