extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
var areaOfOrigin : AreaOfControl = null
var areaOfDestination : AreaOfControl = null
var selectedCard : Card = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ray_cast_update()
	
	if Input.is_action_just_pressed("left_click"):
		if ray_cast_3d.is_colliding():
			var selectedObject = ray_cast_3d.get_collider()
			print(selectedObject)
			if selectedObject is AreaOfControl:
				areaOfOrigin = select_area()
			if selectedObject is Card:
				selectedCard = selectedObject
				selectedCard._select(true)

	if Input.is_action_just_released("left_click"):
		if ray_cast_3d.is_colliding():
			var selectedObject = ray_cast_3d.get_collider()
			print(selectedObject)
			if selectedObject is AreaOfControl:
				areaOfDestination = select_area()
				check_area_selection()
				if selectedCard:
					use_card(areaOfDestination)
		if(selectedCard):
			selectedCard._select(false)
		selectedCard = null
		areaOfDestination = null
		areaOfOrigin = null
	

func ray_cast_update() -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * 10
	ray_cast_3d.force_raycast_update()
	

func select_area() -> Area3D:
	var collisionPoint = ray_cast_3d.get_collision_point()
	var selectedArea = ray_cast_3d.get_collider()
	return selectedArea

func check_area_selection() -> void:
	if areaOfOrigin && areaOfDestination :
		areaOfOrigin != areaOfDestination
		areaOfOrigin.give_move_order(areaOfDestination, 1)

func use_card(location: AreaOfControl)-> void:
	location.card_used(selectedCard)
	selectedCard.resource.PlayCard(location)
	
