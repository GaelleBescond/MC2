extends Node3D

@export var camera_speed := 4.0
@export var scroll_speed := 10.0
@export var money := 5:
	set(money_in):
		money = max(money_in,0) #clamps  to the biggest value, so if negative it goes back to zero
		print(money)
@onready var label_fps: Label = $HUD/OptionsContainer/LabelFPS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_camera(delta)
	label_fps.set_text("FPS " + str(Engine.get_frames_per_second()))

func move_camera(delta) -> void:
	if Input.is_action_pressed("input_up"):
		translate (Vector3(0,0,-delta * camera_speed))
	if Input.is_action_pressed("input_down"):
		translate (Vector3(0,0,delta * camera_speed))
	if Input.is_action_pressed("input_left"):
		translate (Vector3(-delta * camera_speed,0,0))
	if Input.is_action_pressed("input_right"):
		translate (Vector3(delta * camera_speed,0,0))
	if Input.is_action_pressed("input_high"):
		translate (Vector3(0, delta * camera_speed,0))
	if Input.is_action_pressed("input_low"):
		translate (Vector3(0, -delta * camera_speed,0))
	if Input.is_action_just_pressed("input_high_scroll"):
		translate (Vector3(0, -delta * camera_speed * scroll_speed	,0))
	if Input.is_action_just_pressed("input_low_scroll"):
		translate (Vector3(0, delta * camera_speed * scroll_speed,0))
		

#send to level manager if player uses a card
func player_use_card() -> void:
	#If handled card is dropped on valid terrain
	if Input.is_action_pressed("ui_accept"):
		return #print("player used a card")

#send to level manager if player gives unit move order
func player_gives_move_order() -> void:
	pass

func update_money(moneyChange:int) -> void:
	money += moneyChange
