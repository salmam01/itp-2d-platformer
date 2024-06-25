extends Area2D

@export var void_level = 2100
@export var orb_visible = true
@onready var orb_collected = $OrbCollected

func _on_body_entered(body):
	if(body.name == "Player"):
		orb_collected.play("collected")
		await orb_collected.animation_finished
		queue_free()
