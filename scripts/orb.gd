extends Area2D

@export var void_level = 2100
@export var orb_visiable = true


func _on_body_entered(body):
	if(body.name == "Player"):
		queue_free()
