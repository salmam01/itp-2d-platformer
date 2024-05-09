# player.gd
extends Node2D

@export var start_pos_orb = Vector2(1002,310)
@export var orb_hide_pos = Vector2(1002,1100)

func _on_player_free_orb():
	position = orb_hide_pos



func _on_player_show_orb():
	position = start_pos_orb
