@tool
extends Node2D
class_name ChessPiece

enum TYPE{
	PAWN,
	BISHOP,
	KNIGHT,
	ROOK,
	QUEEN,
	KING
}

enum COLOR{
	WHITE,
	BLACK
}

#https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#properties-setters-and-getters

@export_category("Piece Properties")
@export var type := TYPE.PAWN :
	set(value):
		type = value
		if sprite != null:
			updateSprite()
		
@export var color := COLOR.WHITE :
	set(value):
		color = value
		if sprite != null:
			updateSprite()
		
@export var spriteFrame = 0

@onready var sprite = $Sprite2D
@onready var audioStreamPlayer = $AudioStreamPlayer
#@onready var animationPlayer = $AnimationPlayer
@onready var animationPlayer2 = $AnimationPlayer2

var clicks = 0
var selected = false
var hovering_over = false
var past_position : Vector2
var BOUNDS = {"left": 0, "right": 0, "up": 0, "down": 0}
var initial_position : Vector2

signal move
signal selected_piece
signal piece_selected

func updateSprite():
	self.spriteFrame = self.type
	if self.color == COLOR.BLACK:
		self.spriteFrame = self.spriteFrame + 6
	sprite.frame = self.spriteFrame

func _ready():
	updateSprite()
	initial_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if selected:
#		sprite.material.set_shader_parameter("active", true)
		pass
	elif hovering_over:
		if color == COLOR.WHITE:
			sprite.material.set_shader_parameter("color", Color.SPRING_GREEN)
		else:
			sprite.material.set_shader_parameter("color", Color.RED)
		sprite.material.set_shader_parameter("active", true)
	else:
		sprite.material.set_shader_parameter("active", false)
		
func followMouse():
	var mouse_position = get_global_mouse_position().snapped(Vector2(64, 64))
	if not (mouse_position.x < BOUNDS["left"]
			or mouse_position.x > BOUNDS["right"]
			or mouse_position.y < BOUNDS["up"]
			or mouse_position.y > BOUNDS["down"]):
		if mouse_position != global_position:
			animationPlayer2.play("wobble")
			if mouse_position.x < global_position.x:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
		global_position = mouse_position
	
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		audioStreamPlayer.play()
		emit_signal("piece_selected", self)
#		selected = !selected
#		if selected:
#			emit_signal("selected_piece", self)
#		else:
#			Input.set_custom_mouse_cursor(null)
#			emit_signal("move", self, position)

func _on_area_2d_mouse_shape_entered(shape_idx):
	hovering_over = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_area_2d_mouse_shape_exited(shape_idx):
	hovering_over = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

