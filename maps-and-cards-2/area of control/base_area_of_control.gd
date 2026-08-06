extends Area3D

@export var player := 0
@export var captureGauge := 100.0
var squadsInside : Array[Node] = []
var playerOwner : int :
	set (ownerchange):
		var color: Color
		owner_ui.text = "Player" + str(player)
		if ownerchange == 1:
			color = Color.DARK_BLUE
			owner_ui.modulate = color
		else:
			if ownerchange == 2:
				color = Color.DARK_RED
				owner_ui.modulate = color

@onready var area_unit_collider: CollisionShape3D = $area_unit_collider
@onready var csg_combiner_3d: CSGCombiner3D = $CSGCombiner3D
@onready var owner_ui: Label3D = $OwnerUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_overlapping_bodies())
	for body in get_overlapping_bodies():
		if body.is_in_group("Squad_Handler"):
			
			body.append(squadsInside)
	print(squadsInside)
	playerOwner = player
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	csg_combiner_3d.visible = true
func _on_mouse_exited() -> void:
	csg_combiner_3d.visible = false


func _on_timer_timeout() -> void:
	pass

func check_squads_inside() -> void:
	pass


func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	squadsInside.append_array(body)
	print(body_rid)
	
