extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_spawn_timeout() -> void:
	for area : AreaOfControl in get_tree().get_nodes_in_group("EnemyAreaLogic"):
		#area.card_used()
		area.give_move_order(area.destinationArea, 2)
	
	pass # Replace with function body.
