extends Area2D

signal reset

@export var void_level = 2500
@export var orb_visible = true
@onready var orb_collected = $OrbAnimation


func _on_body_entered(body):
	if(body.name == "Player"):
		if(orb_visible):
			orb_collected.play("collected")
			await orb_collected.animation_finished
			position.y -= void_level
			orb_visible = false

func _on_player_show_orb():
	if(!orb_visible):
		position.y += void_level
		orb_visible = true
		emit_signal("reset")
