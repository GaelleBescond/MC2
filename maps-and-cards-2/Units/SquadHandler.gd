extends CharacterBody3D
class_name squadHandler

@export var squadSpeed := 5.0
@export var player := 0
@export var squadHP := 100
@export var squadDamage := 5
@export var squadAttackSpeed := 5 #counted as DPM? DPS?
const BLUE_TEAM = preload("uid://dc5v1hx8uvajv")
const RED_TEAM = preload("uid://vyclqed7ewpv")

	

var playerOwner : int :
	#stupid,
	set (ownerchange):
		if ownerchange == 1:
			unit_team.set_surface_override_material(0,BLUE_TEAM)
			print("blue")
		else:
			if ownerchange == 2:
				unit_team.set_surface_override_material(0,RED_TEAM)
				print("red")
			else:
				print(ownerchange)

var originPosition : = Vector3()
var targetPosition : = Vector3(0,0,0)
var isInCombat := false
@onready var unit_team: MeshInstance3D = $UnitTeam
@onready var unit_bill: MeshInstance3D = $UnitTeam/UnitBill
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	playerOwner = player


func _physics_process(delta: float) -> void:
	if !isInCombat:
		var destination = navigation_agent_3d.get_next_path_position()
		var local_destinaton = destination - global_position
		var direction = local_destinaton.normalized()	
		velocity = direction * squadSpeed
		move_and_slide()

func received_move_order(targetPosition) -> void:
	navigation_agent_3d.set_target_position(targetPosition)


func _on_navigation_agent_3d_target_reached() -> void:
	originPosition = targetPosition

func retreat() -> void:
	pass

func toggle_combat_mode(switch) -> void:
	isInCombat = switch
