extends Control

@onready var main = $"../../"
@onready var pause_menu = main.get_node("PauseLayer/PauseMenu")


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_resume_pressed():
	pause_menu.visible = false
	get_tree().paused = false
	Engine.time_scale = 1

func _on_restart_pressed():
	var current_scene = get_tree().current_scene
	get_tree().paused = false
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
	
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
