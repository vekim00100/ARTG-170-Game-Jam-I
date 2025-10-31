class_name Parasite
extends CharacterBody3D

@onready var player_model = $CollisionShape3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const INITIAL_VELOCITY = 10


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if velocity: #Handles looking direction we're moving.
		player_model.rotation.y = atan2(velocity.x, velocity.z)
	move_and_slide()
