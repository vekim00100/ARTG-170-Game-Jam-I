class_name Wound
extends Node

#Variables
var wound_table = {
	"Abrasion": {"Bleed": 1, "Pain": 10, "Infection": 7}, #Stage 1 Abrasion
	"Laceration": {"Bleed": 2, "Pain": 15, "Infection": 7}, #Stage 2
	
	"Puncture": {"Bleed": 1, "Pain": 5, "Infection": 5}, #State 1 Puncture
	"Penetration": {"Bleed": 1, "Pain": 10, "Infection": 5}, #Stage 2
	
	"Hematoma": {"Bleed": 0, "Pain": 10, "Infection": 0}, #Stage 1 Bruise
	
	"Burned": {"Bleed": 0, "Pain": 15, "Infection": 5}, #stage 1 Burn
	"Charred": {"Bleed": 0, "Pain": 20, "Infection": 10}, #Stage 2
	
	"Broken": {"Bleed": 0, "Pain": 25, "Infection": 0}, #Stage 1 Broken
	"Shattered": {"Bleed": 0, "Pain": 35, "Infection": 0}, #Stage 2
	}
	
var wound_type = null #Abrasion, puncture, broken bone, etc.
var wound_location = null #Foot, hands, torso, etc.
var pain = 0.0
var bleed_rate = 0.0
var infection_chance = 0.0
var infection_level = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
