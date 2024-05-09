extends Area2D

@export var void_level = 1100

func _on_player_free_orb():
	position.y -= void_level
func _on_player_show_orb():
	position.y += void_level

func _on_player_free_health_orb():
	position.y -= void_level
func _on_player_show_health_orb():
	position.y += void_level
	
func _on_player_free_dash_orb():
	position.y -= void_level
func _on_player_show_dash_orb():
	position.y += void_level
	
func _on_player_free_jump_orb():
	position.y -= void_level
func _on_player_show_jump_orb():
	position.y += void_level

func _on_player_free_jump_orb_2():
	position.y -= void_level
func _on_player_show_jump_orb_2():
	position.y += void_level
