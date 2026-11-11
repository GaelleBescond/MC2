extends Node
class_name LevelLogic

@export var level_passive_income := 3
@export var enemy_squad : PackedScene
#var player = get_tree().get_first_node_in_group("Player")
@onready var player: Node3D = $Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_child_entered_tree(node: Node) -> void:
	pass # Replace with function body.	

func pass_move_order(destinationTarget) -> void:
	get_tree().call_group("Squad_Handler", "received_move_order")
	
func update_money(money) -> void:
	player.update_money(money)
	

func _on_timer_area_capture_timeout() -> void:
	for area : AreaOfControl in get_tree().get_nodes_in_group("AreaOfControl"):
		area.checkSquadsCapture()

func _on_timer_money_timeout() -> void:
	update_money(level_passive_income)


func _on_enemy_spawn_timeout() -> void:
	for area : AreaOfControl in get_tree().get_nodes_in_group("EnemyAreaLogic"):
		#_spawn_unit(area)
		area.give_move_order(area.destinationArea, 2)
	
func _spawn_unit(area) -> void:
	var new_squad= enemy_squad.instantiate()
	new_squad.global_position = area.global_position
