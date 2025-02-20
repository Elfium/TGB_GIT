class_name UiHeader extends PanelContainer


@onready var level_label: Label = %LevelLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var feedback_container: CenterContainer = %FeedbackContainer


func _ready() -> void :
	Experience.ref.experience_created.connect(on_experience_created)
	Experience.ref.level_up.connect(on_level_up)
	
	update()


func update() -> void :
	level_label.text = str(Experience.ref.get_level())
	progress_bar.value = Experience.ref.get_experience()
	progress_bar.max_value = Experience.ref.get_experience_for_next_level()


func create_feedback(experience : int) -> void : 
	var feedback : Label = Label.new()
	feedback.text = "+ %s exp" %experience
	
	feedback_container.add_child(feedback)
	
	var tween : Tween = create_tween()
	await tween.tween_property(feedback, "modulate:a" , 0.0, 0.3).set_trans(Tween.TRANS_CIRC).finished
	
	feedback.queue_free()


func on_experience_created(experience : int, _level : int) -> void :
	update()
	create_feedback(experience)


func on_level_up(_new_level : int, _previous_level : int) -> void :
	pass
