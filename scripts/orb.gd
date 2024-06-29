extends Area2D

@export var void_level = 2500
@export var orb_visible = true


func _on_body_entered(body):
	if(body.name == "Player"):
		if(orb_visible):
			$OrbAnimation.play("collected")
			await $OrbAnimation.animation_finished
			position.y -= void_level
			orb_visible = false

func _on_player_show_orb():
	if(!orb_visible):
		$OrbAnimation.play("idle")
		position.y += void_level
		orb_visible = true
