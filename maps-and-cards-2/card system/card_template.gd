extends Area3D

class_name Card

@export_category("Data")
@export var cardName = "Placeholder"
@export var cardCost = 3

@onready var name_label: Label3D = $Front/NameLabel
@onready var cost_label: Label3D = $Front/CostLabel

@export_category("UX")
var scaleBase = Vector3(1,1,1)
@onready var front: MeshInstance3D = $Front
@export var scaleRatio = 1.5
var _locationBase = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_label.text = cardName
	cost_label.text = str(cardCost)
	position += Vector3(0,-0.1,0)
	pass # Replace with function body.



func _on_mouse_entered() -> void:
	front.scale *= scaleRatio
	front.position +=  Vector3(0,0,-.5)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	front.scale = scaleBase
	front.position = _locationBase
	pass # Replace with function body.
