extends Area3D

class_name AreaOfControl

var squadsInside : Array[squadHandler] = []
var playerOwner : int :
	set (ownerChange):
		var color: Color
		if ownerChange == 1:
			color = Color.DODGER_BLUE
			name_ui.modulate = color
		else:
			if ownerChange == 2:
				color = Color.RED
				name_ui.modulate = color


@export_category("Area ownership")
@export var player := 0
@export var captureGauge : float = 100.0:
	set (captureChange):
		captureGauge = max(captureChange,0)
		captureGauge = min(captureChange,100)
		if captureGauge <= 0:
			player = 1
			playerOwner = player
			
@export var captureRate := 5
@export var areaName = "AreaName"
var enemyUnits := 0
var alliedUnits := 0

@export_category("Area type")
@export var canSpawnSquads := false
@export_enum("Empty", "Plaza", "Artillery") var areaType
@export_enum("Crossroad", "Cul de sac", "Plaza", "Straight Road", "Turn Sharp", "Turn Wide") var areaTile
@export_enum("1", "2", "3") var tileVariant



@onready var area_unit_collider: CollisionShape3D = $area_unit_collider
@onready var name_ui: Label3D = $NameUI
@onready var hover_toggle: CSGCombiner3D = $"Hover toggle"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerOwner = player
	name_ui.text = str(areaName)
	

func checkSquadsCapture() -> void:
	for squad in squadsInside:
		if squad.player == player:
			alliedUnits +=1
		if squad.player != player:
			enemyUnits +=1
	if alliedUnits >= 1 && enemyUnits == 0 :
		captureGauge += captureRate
	if alliedUnits == 0 && enemyUnits >= 1 :
		captureGauge -= captureRate
	enemyUnits = 0
	alliedUnits = 0
	

#Hover feedbacks
func _on_mouse_entered() -> void:
	hover_toggle.visible = true

func _on_mouse_exited() -> void:
	hover_toggle.visible = false

#Timer ticking logic (capture, cards, money, etc)
func _on_timer_timeout() -> void:
	pass

#Array units inside 
func _on_body_entered(body: Node3D) -> void:
	squadsInside.append(body)
	check_enemity()
	
func _on_body_exited(body: Node3D) -> void:
	squadsInside.erase(body)
	check_enemity()

func give_move_order(destination, player) -> void:
	#print("move order received by " + str(destination)+" from player "+ str(player))
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

func card_used(card) -> void:
	
	print(card.name)
