extends Area3D

@export var text_key: = ""

var player_in_area = false

func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	player_in_area = false

func _input(event):
	if Dialogic.current_timeline != null:
		return

	if player_in_area && event.is_action_pressed("Context_Interact"): 
		print("Starting dialogue:")
		print(text_key)
		Dialogic.start(str(text_key))
		get_viewport().set_input_as_handled()

func _on_body_entered(_body: Node3D) -> void:
	player_in_area = true
	SignalBus.player_interaction_available.emit(text_key)
	print("Area entered.")


func _on_body_exited(_body: Node3D) -> void:
	player_in_area = false
	SignalBus.player_interaction_available.emit(null)
	print("Area exited.")
