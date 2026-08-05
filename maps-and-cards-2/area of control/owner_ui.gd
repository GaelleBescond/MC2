extends Label3D

@onready var base_area_of_control: Area3D = $".."



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	set_node_player_owner()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_node_player_owner() -> void:
	if base_area_of_control.Owner == "Player 0" :
		text = "Player 0"
	if base_area_of_control.Owner == "Player 1" :
		text = "Player 1"
	if base_area_of_control.Owner == "Player 2" :
		text = "Player 2"
