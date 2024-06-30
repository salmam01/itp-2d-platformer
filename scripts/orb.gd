extends Area2D

@export var void_level = 2500
@export var orb_visible = true
@onready var orb_animation = $OrbAnimation


func _on_body_entered(body):
	if(body.name == "Player"):
		if(orb_visible):
			orb_animation.play("collected")
			await orb_animation.animation_finished
			position.y -= void_level
			orb_visible = false

func _on_player_show_orb():
	if(!orb_visible):
		orb_animation.play("idle")
		position.y += void_level
		orb_visible = true
