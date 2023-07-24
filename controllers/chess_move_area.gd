extends Area2D

@onready var collisionShape = $CollisionShape2D
var blue = Color(0, 0, 0.5, 0.5)
var red = Color(0.5, 0, 0, 0.5)
var green = Color(0, 0.5, 0, 0.5)

func _ready():
	collisionShape.set("debug_color", blue)

func _on_area_entered(area):
	collisionShape.set("debug_color", green)
	
func _on_area_exited(area):
	collisionShape.set("debug_color", red)

