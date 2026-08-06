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
@export var canSpawnSquads := false

@onready var area_unit_collider: CollisionShape3D = $area_unit_collider
@onready var csg_combiner_3d: CSGCombiner3D = $CSGCombiner3D
@onready var owner_ui: Label3D = $OwnerUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerOwner = player

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
	#print("IN " + str(squadsInside))
	check_enemity()
func _on_body_exited(body: Node3D) -> void:
	#print("SIGNAL OUT:", body)
	squadsInside.erase(body)
	#print("OUT " + str(squadsInside))
	check_enemity()

func give_move_order(destination, player) -> void:
	print("move order received by " + str(destination)+" from player "+ str(player))
	for squad in squadsInside:
		if squad.player == player && !squad.isInCombat:
			squad.received_move_order(destination.global_position)
		else:
			print("Squad pinned")

func check_enemity() -> void:
	if squadsInside.size() >= 1:
		var squadIndex := squadsInside[0]
		var playerCheck : int = squadIndex.player
		var enemity := false
		for squad in squadsInside:
			if (squad.player != playerCheck) && (playerCheck != 0):
				print(str(squad.player) + " enemity " + str(playerCheck))
				enemity = true
				break
		for squad in squadsInside:
			squad.toggle_combat_mode(enemity)
			print(squad.isInCombat)
	else:
		print("nobody")
	return
