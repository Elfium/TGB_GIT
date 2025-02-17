extends Node

var sound_databse = {}


func _ready():
	get_sound(0, $button_sound_0)
	get_sound(1, $button_sound_1)
	get_sound(2, $button_sound_2)
	get_sound(3, $button_sound_3)
	
	get_sound(5, $craft_item_1)







func get_sound(sound_id: int, audio_node: AudioStreamPlayer) -> void:
	sound_databse[sound_id] = audio_node

func play_sound(sound_id: int, pitch : float) -> void:
	if sound_databse.has(sound_id):
		var audio_node = sound_databse[sound_id]
		if audio_node and audio_node is AudioStreamPlayer:
			audio_node.pitch_scale = pitch
			audio_node.play()
