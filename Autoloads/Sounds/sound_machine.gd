extends Node

var sound_databse = {}


func _ready():
	get_sound(0, $button_1_sound)
	get_sound(5, $craft_item_1)







func get_sound(sound_id: int, audio_node: AudioStreamPlayer) -> void:
	sound_databse[sound_id] = audio_node

func play_sound(sound_id: int) -> void:
	if sound_databse.has(sound_id):
		var audio_node = sound_databse[sound_id]
		if audio_node and audio_node is AudioStreamPlayer:
			audio_node.play()
