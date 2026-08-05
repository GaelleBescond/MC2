extends Area3D

@export var Owner := "Player 0"
@export var capture_gauge := 1.0
@onready var csg_cylinder_3d: CSGCylinder3D = $CSGCylinder3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	csg_cylinder_3d.visible = true
	
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	csg_cylinder_3d.visible = false
	pass # Replace with function body.
