extends Area3D

@export var text_key := "door_interact"
var nearDoor := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if nearDoor and Input.is_action_just_pressed("Context_Interact"):
		# Change to the new scene when player presses F
		get_tree().change_scene_to_file("res://scenes/doorscene.tscn")

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Debug Player":
		nearDoor = true
		SignalBus.player_interaction_available.emit(text_key)
		print("Player entered door area.")

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Debug Player":
		nearDoor = false
		SignalBus.player_interaction_available.emit(null)
		print("Player left door area.")
