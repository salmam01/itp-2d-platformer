extends Node2D

@onready var pause_menu = $PauseLayer/PauseMenu
@onready var resume_button = $PauseLayer/PauseMenu/MarginContainer/VBoxContainer/Resume
var paused = false

func _ready():
	pause_menu.visible = false
	$LevelEnd/FlagAnimation.play("idle")
	$HealthOrb/OrbAnimation.play("idle")
	$HealthOrb2/OrbAnimation.play("idle")
	$HealthOrb3/OrbAnimation.play("idle")
	$HealthOrb4/OrbAnimation.play("idle")
	$HealthOrb5/OrbAnimation.play("idle")
	$HealthOrb6/OrbAnimation.play("idle")
	$HealthOrb7/OrbAnimation.play("idle")
	$DashOrb/OrbAnimation.play("idle")
	$DashOrb2/OrbAnimation.play("idle")
	$DashOrb3/OrbAnimation.play("idle")
	$DashOrb4/OrbAnimation.play("idle")
	$JumpOrb/OrbAnimation.play("idle")
	$JumpOrb2/OrbAnimation.play("idle")
	$JumpOrb3/OrbAnimation.play("idle")
	$JumpOrb4/OrbAnimation.play("idle")
	$JumpOrb5/OrbAnimation.play("idle")

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()

func toggle_pause_menu():
	paused = !paused
	pause_menu.visible = paused 
	Engine.time_scale = 0 if paused else 1
	
	if paused:
		resume_button.grab_focus() 

