extends Area3D

class_name Card

@onready var front: MeshInstance3D = $Front
var scaleBase = Vector3(1,1,1)
@export var scaleRatio = 1.5
var locationBase = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_mouse_entered() -> void:
	front.scale *= scaleRatio
	front.position +=  Vector3(0,0,-.5)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	front.scale = scaleBase
	front.position = locationBase
	pass # Replace with function body.
