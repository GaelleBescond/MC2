extends Area3D

class_name Card


@export_category("Data")
@export var cardName = "Placeholder"
@export var cardCost = 3

@onready var name_label: Label3D = $Front/NameLabel
@onready var cost_label: Label3D = $Front/CostLabel
@onready var img_sprite: Sprite3D = $Front/Sprite3D

@export_category("UX")
var scaleBase = Vector3(1,1,1)
@onready var front: MeshInstance3D = $Front
@export var scaleRatio = 1.5
var _locationBase = position

#Louis Stuffs
var isSelected : bool = false
var resource : CardResource
var handler : CardHandler

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handler = get_parent() as CardHandler
	name_label.text = cardName
	cost_label.text = str(cardCost)
	position += Vector3(0,-0.1,0)
	pass # Replace with function body.


func _initialize(new_ressource : CardResource, new_handler : CardHandler) -> void:
	resource = new_ressource
	cost_label.text = str(resource._cardCost)
	name_label.text = resource._cardName
	img_sprite.texture = resource._cardImage
	pass

func _select(_isSelected :bool) ->void:
	isSelected = _isSelected
	if(!_isSelected):
		_on_mouse_exited()
	pass


func _on_mouse_entered() -> void:
	front.scale *= scaleRatio
	front.position +=  Vector3(0,0,-.5)
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	if(!isSelected):
		front.scale = scaleBase
		front.position = _locationBase
	pass # Replace with function body.
