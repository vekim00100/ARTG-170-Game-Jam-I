class_name HUD
extends Control
# signal debug_lacerate
# signal debug_puncture

@export var player: Player
@onready var debug_menu = $Debug
@onready var debug_blood_bar = $Debug/Debug_Blood
@onready var debug_pain_bar = $Debug/Debug_Pain
@onready var debug_wound_display = $Debug/Debug_Wounds


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	debug_menu.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	debug_blood_bar.value = player.blood_level
	debug_pain_bar.value = player.pain_level
	# debug_wound_display.text 
	if Input.is_action_just_pressed("Debug_Overlay"):
		print("Debug overlay toggled.")
		if !debug_menu.visible:
			debug_menu.show()
		else:
			debug_menu.hide()

func _on_debug_wound_laceration_pressed() -> void:
	# debug_lacerate.emit()
	player.add_wound("Laceration", "Chest")

func _on_debug_wound_puncture_pressed() -> void:
	# debug_puncture.emit()
	player.add_wound("Puncture", "Chest")
