extends Control


func _ready():
	$MarginContainer/VBoxContainer/bw_button.grab_focus()

func _process(delta):
	pass


func _on_bw_button_pressed():
	GlobalVariables.current_counter_style = "BW_"
	return_to_menu()


func _on_bwg_button_pressed():
	GlobalVariables.current_counter_style = "BWG_"
	return_to_menu()


func _on_rainbow_button_pressed():
	GlobalVariables.current_counter_style = "Rainbow_"
	return_to_menu()


func _on_rb_button_pressed():
	GlobalVariables.current_counter_style = "RG_"
	return_to_menu()


func _on_sprite_button_pressed():
	GlobalVariables.current_counter_style = "Sprite_"
	return_to_menu()


func _on_return_button_pressed():
	return_to_menu()
	
func return_to_menu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
