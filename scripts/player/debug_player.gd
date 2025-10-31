class_name Player
extends CharacterBody3D

signal playerDeath

@onready var player_model = $janedoe

# Player health variables:
var blood_level = 100.0
var pain_level = 0.0
var parasite_location = "Chest"
var parasite_location_target = "Chest"
var wounds = []

var active_use_limbs = [] 

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if velocity: #Handles looking direction we're moving.
		player_model.rotation.y = atan2(velocity.x, velocity.z)
	move_and_slide()
	
func _process(_delta: float) -> void:
	# Life Loop:
	# print("Life loop proc") # DEBUG
	for i in wounds:
		await get_tree().create_timer(.33).timeout # Process 3 times a second.
		blood_level -= (i.bleed_rate / 500.0)
		# print("New blood level:" + str(blood_level)) # DEBUG
		if i.wound_location in active_use_limbs:			#Are you using an injured limb? That'll hurt.
			i.pain *= 1.2
		if i.pain > i.wound_table[i.wound_type]["Pain"]:	#Recovery from exertion. 
			i.pain *= .9
		if blood_level <= 0:
			print("Player has died!")
			playerDeath.emit()
			break
	
	# Parasite movement around body.
	# parasite_location_target defined as future-proofing; I want to add an animation and brief delay of transportation eventually.
	if Input.is_action_just_pressed("Parasite_Head"):
		parasite_location_target = "Head"
		parasite_location = "Head"
	if Input.is_action_just_pressed("Parasite_Chest"):
		parasite_location_target = "Chest"
		parasite_location = "Chest"
	if Input.is_action_just_pressed("Parasite_Arm_R"):
		parasite_location_target = "Arm_R"
		parasite_location = "Arm_R"
	if Input.is_action_just_pressed("Parasite_Arm_L"):
		parasite_location_target = "Arm_L"
		parasite_location = "Arm_L"
	if Input.is_action_just_pressed("Parasite_Leg_R"):
		parasite_location_target = "Leg_R"
		parasite_location = "Leg_R"
	if Input.is_action_just_pressed("Parasite_Leg_L"):
		parasite_location_target = "Leg_L"
		parasite_location = "Leg_L"


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
