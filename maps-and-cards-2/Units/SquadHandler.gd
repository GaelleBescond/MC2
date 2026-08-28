extends CharacterBody3D
class_name squadHandler

@export var squadSpeed := 5.0
@export var player := 0
@export var squadHP := 100
@export var squadDamage := 5
@export var squadAttackSpeed := 5 #counted as DPM? DPS?

	

var playerOwner : int :
	set (ownerchange):
		var material = unit_team.get_active_material(0) as StandardMaterial3D
		print(material)
		if ownerchange == 1:
			material.albedo_color = Color.DODGER_BLUE
			print("blue")
		else:
			if ownerchange == 2:
				material.albedo_color = Color.RED
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
