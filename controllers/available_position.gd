extends Node2D
class_name AvailablePosition

var color
signal move_selected
@onready var sprite = $Sprite2D

func setup(_color, _position):
	color = _color
	position = _position
	
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		emit_signal("move_selected", position)

func _on_area_2d_mouse_entered():
	sprite.material.set_shader_parameter("active", true)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
func _on_area_2d_mouse_exited():
	sprite.material.set_shader_parameter("active", false)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

