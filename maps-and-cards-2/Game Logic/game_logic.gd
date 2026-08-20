extends Node
class_name GameLogic

@export var level_passive_income := 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func test() -> void:
	pass

func _on_child_entered_tree(node: Node) -> void:
	pass # Replace with function body.

func pass_move_order(destinationTarget) -> void:
	get_tree().call_group("Squad_Handler", "received_move_order")
	
func update_money(money) -> void:
	for player in get_tree().get_nodes_in_group("Player"):
		player.update_money(money)
	

func _on_timer_area_capture_timeout() -> void:
	print("cap")
	for area : AreaOfControl in get_tree().get_nodes_in_group("AreaOfControl"):
		area.checkSquadsCapture()

func _on_timer_money_timeout() -> void:
	update_money(level_passive_income)
