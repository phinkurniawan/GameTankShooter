extends Control

var start_pos: Vector2 = Vector2.ZERO
var end_pos: Vector2 = Vector2.ZERO
var valid_pos = false
onready var js_pos = get_node("Background").react_position
onready var js_bag = get_node("Background")
onready var js_handle = get_node("Background/bottom")

func _input(event: InputEvent) -> void:
	if valid_pos:
		if event is InputEventScreenDrag:
			if start_pos == Vector2.ZERO:
				start_pos = event.position
				js_bag.react_position = start_pos
				

func _on_TextureButton_button_down():
	valid_pos = true
