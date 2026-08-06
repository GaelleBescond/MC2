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
	playerOwner = player
	await get_tree().create_timer(0.1).timeout
	for body in get_overlapping_bodies():
		squadsInside.append(body)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#Hover feedbacks
func _on_mouse_entered() -> void:
	csg_combiner_3d.visible = true
	
func _on_mouse_exited() -> void:
	csg_combiner_3d.visible = false

#Timer ticking logic (capture, cards, money, etc)
func _on_timer_timeout() -> void:
	pass

#Array units inside 
func _on_body_entered(body: Node3D) -> void:
	#print("SIGNAL IN:", body.name)
	squadsInside.append(body)
func _on_body_exited(body: Node3D) -> void:
	#print("SIGNAL OUT:", body.name)
	squadsInside.erase(body)
