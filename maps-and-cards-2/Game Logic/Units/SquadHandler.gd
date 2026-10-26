extends CharacterBody3D
class_name squadHandler

@onready var hp_bar: Label3D = $HP_bar

@export_category("Temporay Combat variables")
@export var squadSpeed := 5.0
@export var player := 0
@export var squadMaxHP := 100
var squadHP : int :
	set (hpchange):
		squadHP = hpchange
		hp_bar.text = str(squadHP)
		
@export var squadDamage := 5
@export var squadAttackSpeed := 1 #time between attacks
@onready var temp_combat_timer: Timer = $TempCombatTimer
#variables for temporary combat

const BLUE_TEAM = preload("uid://dc5v1hx8uvajv")
const RED_TEAM = preload("uid://vyclqed7ewpv")

var playerOwner : int :
	set (ownerchange):
		if ownerchange == 1:
			unit_team.set_surface_override_material(0,BLUE_TEAM)
			#print("blue")
		else:
			if ownerchange == 2:
				unit_team.set_surface_override_material(0,RED_TEAM)
				#print("red")
			#else:
				#print(ownerchange)

var originPosition := Vector3()
var targetPosition := Vector3(0,0,0)
var isInCombat := false
var target : squadHandler
@onready var unit_team: MeshInstance3D = $UnitTeam
@onready var unit_bill: MeshInstance3D = $UnitTeam/UnitBill
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	playerOwner = player   
	temp_combat_timer.wait_time = squadAttackSpeed
	squadHP = squadMaxHP


func _physics_process(delta: float) -> void:
	if !isInCombat:
		var destination = navigation_agent_3d.get_next_path_position()
		var local_destinaton = destination - global_position
		var direction = local_destinaton.normalized()	
		velocity = direction * squadSpeed
		move_and_slide()
	if isInCombat && temp_combat_timer.is_stopped():
		temp_combat_timer.start()
		
		#print(self.name)

func received_move_order(targetPosition) -> void:
	navigation_agent_3d.set_target_position(targetPosition)


func _on_navigation_agent_3d_target_reached() -> void:
	originPosition = targetPosition

func retreat() -> void:
	pass

func toggle_combat_mode(switch) -> void:
	isInCombat = switch

func find_target(squads_list: Array) -> squadHandler:

	for squad in squads_list:
		if squad.player != player:
			target = squad
			print(target)
			temp_combat_timer.start()
			return
	print("no target in sight")
	return

func attack_target() -> void:
	target.receive_damage(squadDamage)

func receive_damage(damage: int) -> void:
	squadHP -= damage


func _on_temp_combat_timer_timeout() -> void:
	if isInCombat:
		temp_combat_timer.start()
		attack_target()
