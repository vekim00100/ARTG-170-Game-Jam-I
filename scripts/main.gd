extends Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		SignalBus.player_interaction_available.emit(null)
		Dialogic.start(str("introduction_monologue"))
		get_viewport().set_input_as_handled()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
