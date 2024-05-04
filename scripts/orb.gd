# player.gd
extends Node2D

func _on_player_free_orb():
	queue_free()
