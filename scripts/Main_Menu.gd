extends Control


func _ready():
	$VBoxContainer/Start_Button.grab_focus()


func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
