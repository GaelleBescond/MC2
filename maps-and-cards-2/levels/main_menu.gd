extends CanvasLayer



@onready var play_button: Button = $CenterContainer/VBoxContainer/PlayButton
@onready var settings_button: Button = $CenterContainer/VBoxContainer/SettingsButton
@onready var quit_button: Button = $CenterContainer/VBoxContainer/QuitButton
@export_file("*.tscn") var level_file_path
var loading_screen = load("res://levels/loading_screen.tscn")


func _on_play_button_pressed() -> void:
	start_game(level_file_path)

func _on_settings_button_pressed() -> void:
	
	pass
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func start_game(level_to_open) -> void:
	get_tree().change_scene_to_file(level_to_open)
