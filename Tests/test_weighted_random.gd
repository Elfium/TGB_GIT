extends Control


@onready var heads : int = 10
@onready var tails : int = 90


func _process(delta: float) -> void:
	$heads.text = str(heads)
	$tails.text = str(tails)
	tails = 100 - heads
	heads = clamp(heads,0,100)
	tails = clamp(tails,0,100)



func _on_decrease_pressed() -> void:
	heads -= 10


func _on_increase_pressed() -> void:
	heads += 10
