extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
var selected_area 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 10000
	ray_cast_3d.force_raycast_update()
	
	if Input.is_action_just_pressed("left_click"):
		select_area()
	#else:
	#	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	#else:
	#	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func select_area() -> void:
	if ray_cast_3d.is_colliding():
		var collision_point = ray_cast_3d.get_collision_point()		
		print(collision_point)
		
	else:
		print("no detected surface")
