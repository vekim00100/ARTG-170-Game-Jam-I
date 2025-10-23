@tool
extends Control
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Splitter
#	https://github.com/CodeNameTwister/Script-Splitter
#
#	Script Splitter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

signal on_pin(button : Object)

@export var color_rect : ColorRect
@export var button_main : Button
@export var button_close : Button
@export var button_pin : Button
@export var changes : Label

var is_pinned : bool = false

func _ready() -> void:
	mouse_entered.connect(_on_enter)
	mouse_exited.connect(_on_exit)
	
	var c : Color = Color.WHITE
	c.a = 0.25
	button_close.set(&"theme_override_colors/icon_normal_color", c)
	if !is_pinned:
		button_pin.set(&"theme_override_colors/icon_normal_color", c)
	_on_exit()
	
func _on_enter() -> void:
	add_to_group(&"__SPLITER_BUTTON_TAB__")

func _on_exit() -> void:
	remove_from_group(&"__SPLITER_BUTTON_TAB__")
	

func get_reference() -> TabBar:
	return get_parent().get_parent().get_parent().get_reference()

func get_button_pin() -> Button:
	return button_pin

func _on_pin_pressed() -> void:
	on_pin.emit(self)

func set_close_visible(e : bool) -> void:
	button_close.visible = e 

func set_src(src : String) -> void:
	button_main.tooltip_text = src
	
func get_src() -> String:
	return button_main.tooltip_text

func set_text(txt : String) -> void:
	if txt.ends_with("(*)"):
		button_main.text = txt.trim_suffix("(*)")
		changes.modulate.a = 1.0
		return
	button_main.text = txt
	changes.modulate.a = 0.0

func get_button() -> Button:
	return button_main

func get_button_close() -> Button:
	return button_close
