extends CharacterBody3D

@export var squadSpeed := 5.0
@export var player := 0
var playerOwner : int :
	set (ownerchange):
		if label_3d != null:
			var color: Color
			label_3d.text = "Player" + str(player)
			if ownerchange == 1:
				color = Color.DARK_BLUE
				label_3d.modulate = color
			else:
				if ownerchange == 2:
					color = Color.DARK_RED
					label_3d.modulate = color
var originPosition : = Vector3()
var targetPosition : = Vector3(0,0,0)
var isInCombat := false

@onready var label_3d: Label3D = $Label3D
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	playerOwner = player
	#received_move_order(targetPosition)


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
