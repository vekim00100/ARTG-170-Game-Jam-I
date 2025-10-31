extends Node3D

@export var host: Player


var parasite_scene = preload("res://scenes/parasite.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# Character Controller
	var input_dir := Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	var direction := (host.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		host.velocity.x = direction.x * host.SPEED
		host.velocity.z = direction.z * host.SPEED
	else:
		host.velocity.x = move_toward(host.velocity.x, 0, host.SPEED)
		host.velocity.z = move_toward(host.velocity.z, 0, host.SPEED)

	# Parasite Jump
	if Input.is_action_just_pressed("Host_Eject") and host.is_on_floor():
		var parasite = parasite_scene.instantiate()
		add_child(parasite)
		# Inherit position and rotation.
		parasite.global_position = host.global_position
		parasite.rotation.y = host.rotation.y
		print("debug_host_eject")
		#set_process_input(false) # Should apply to only host in the future.
