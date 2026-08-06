extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
var areaOfOrigin : Area3D
var areaOfDestination : Area3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 10000
	ray_cast_3d.force_raycast_update()
	
	if Input.is_action_just_pressed("left_click"):
		areaOfOrigin = select_area()
		#print(str(areaOfOrigin) + " Area of Origin")
	if Input.is_action_just_released("left_click"):
		areaOfDestination = select_area()
		#print(str(areaOfDestination) + " Area of destination")
	if areaOfOrigin != null && areaOfDestination != null:
		areaOfOrigin != areaOfDestination
		areaOfOrigin.give_move_order(areaOfDestination, 1)
		"""else:
			print("same area")"""
		areaOfDestination = null
		areaOfOrigin = null

func select_area() -> Area3D:
	if ray_cast_3d.is_colliding():
		var collisionPoint = ray_cast_3d.get_collision_point()
		var selectedArea = ray_cast_3d.get_collider()
		return selectedArea
	else:
		return null
