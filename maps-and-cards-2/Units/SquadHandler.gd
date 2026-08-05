extends CharacterBody3D

@export var squad_speed := 5.0
var originPosition : = Vector3()
var targetPosition : = Vector3(0,0,0)
var moveOrder := false:
	set(hasMoveOrder):
		print("Move order :" + str(hasMoveOrder))
var isInCombat := false:
	set(combat):
		print("in combat :" + str(combat))


@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	moveOrder = true



func _physics_process(delta: float) -> void:
	if moveOrder:
		var destination = navigation_agent_3d.get_next_path_position()
		var local_destinaton = destination - global_position
		var direction = local_destinaton.normalized()	
		velocity = direction * squad_speed
		move_and_slide()

func received_move_order(targetPosition) -> void:
	moveOrder= true
	navigation_agent_3d.set_target_position(targetPosition)


func _on_navigation_agent_3d_target_reached() -> void:
	if !isInCombat:
		if !moveOrder:
			originPosition = targetPosition

func retreat() -> void:
	pass
