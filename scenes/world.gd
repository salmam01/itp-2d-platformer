extends Node2D

@onready var pause_menu = $PauseLayer/PauseMenu
@onready var resume_button = $PauseLayer/PauseMenu/MarginContainer/VBoxContainer/Resume
var paused = false

func _ready():
	pause_menu.visible = false
	$LevelEnd/FlagAnimation.play("idle")

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()

func toggle_pause_menu():
	paused = !paused
	pause_menu.visible = paused 
	Engine.time_scale = 0 if paused else 1
	
	if paused:
		resume_button.grab_focus() 

