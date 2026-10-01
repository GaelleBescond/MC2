extends Node

@export var enemy_squad : PackedScene

func _on_enemy_spawn_timeout() -> void:
	for area : AreaOfControl in get_tree().get_nodes_in_group("EnemyAreaLogic"):
		_spawn_unit(area)
		
		area.give_move_order(area.destinationArea, 2)
	

func _spawn_unit(area) -> void:
	var new_squad= enemy_squad.instantiate()
	new_squad.global_position = area.global_position
	var player = get_tree().get_first_node_in_group("Player")
	#player.global_position = new_squad.global_position
