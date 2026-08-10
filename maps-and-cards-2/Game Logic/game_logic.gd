extends Node

@export var level_passive_income := 3



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func test() -> void:
	pass

func _on_child_entered_tree(node: Node) -> void:
	pass # Replace with function body.

func pass_move_order(destinationTarget) -> void:
	get_tree().call_group("Squad_Handler", "received_move_order")

#1 second ticks
func _on_timer_timeout() -> void:
	update_money(level_passive_income)
	#print("every player gets " + str(level_passive_income))
	
	
func update_money(money) -> void:
	get_tree().get_nodes_in_group("Player")
	pass
