class_name Player
extends CharacterBody3D


#Player health variables:
var blood_level = 100.0
var pain_level = 0.0
var wounds = []

var active_use_limbs = [] 

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _process(_delta: float) -> void:
	#Life Loop:
	# print("Life loop proc") # DEBUG
	for i in wounds:
		await get_tree().create_timer(.33).timeout # Process 3 times a second.
		blood_level -= (i.bleed_rate / 500.0)
		# print("New blood level:" + str(blood_level)) # DEBUG
		if i.wound_location in active_use_limbs:			#Are you using an injured limb? That'll hurt.
			i.pain *= 1.2
		if i.pain > i.wound_table[i.wound_type]["Pain"]:	#Recovery from exertion. 
			i.pain *= .9

func add_wound(wound_type = null, location = null):
	var incoming_wound = Wound.new()
	incoming_wound.wound_type = wound_type
	incoming_wound.wound_location = location
	incoming_wound.bleed_rate = incoming_wound.wound_table[wound_type]["Bleed"]
	incoming_wound.pain = incoming_wound.wound_table[wound_type]["Pain"]
	incoming_wound.infection_chance = incoming_wound.wound_table[wound_type]["Infection"]
	wounds.append(incoming_wound)
	print("Wound: " + str(incoming_wound.wound_type) + " | Location: " + str(incoming_wound.wound_location))
	print("Pain: " + str(incoming_wound.pain) + " | Bleed Rate: " + str(incoming_wound.bleed_rate) + " | Infection Chance: " + str(incoming_wound.infection_chance))
	pain_level += incoming_wound.pain
