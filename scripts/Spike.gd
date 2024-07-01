extends Area2D

@export var direction = true
@export var pause_counter = 0
@export var movement_counter = 0
@export var movement_max = 60
@export var pause_max = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if movement_counter == movement_max:
		if pause_counter != pause_max:
			pause_counter += 1
		else:
			pause_counter = 0
			movement_counter = 0
			if direction:
				direction = false
			else: 
				direction = true
	else:
		if direction:
			movement_counter += 1
			position.y += 1
		else:
			movement_counter += 1
			position.y -= 1
