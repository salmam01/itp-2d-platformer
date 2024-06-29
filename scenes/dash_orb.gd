extends "res://scripts/orb.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	$OrbAnimation.play("idle")


func _on_orb_reset():
	$OrbAnimation.play("idle")
