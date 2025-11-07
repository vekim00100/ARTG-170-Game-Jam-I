extends Node3D

func _ready():
	$AnimationPlayer.play("door_open")
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == "door_open":
		get_tree().change_scene_to_file("res://scenes/main.tscn")
