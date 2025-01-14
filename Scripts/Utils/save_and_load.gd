class_name SaveAndLoad
##


##
const PATH : String = "user://save.tres"


##
static func save_data() -> void  : 
	ResourceSaver.save(Game.ref.data, PATH)


##
static func load_data() -> Data :
	if ResourceLoader.exists(PATH) : 
		return ResourceLoader.load(PATH)
	else : 
		return Data.new()
