extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 100000
	ray_cast_3d.force_raycast_update()
	
	if Input.is_action_just_pressed("left_click"):
		if ray_cast_3d.is_colliding():
			var collision_point = ray_cast_3d.get_collision_point()		
			print(collision_point)
			#get_tree().
		else:
			print("no detected surface")
	#else:
	#	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	#else:
	#	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
