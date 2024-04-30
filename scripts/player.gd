extends CharacterBody2D

@export var speed = 350
@export var gravity = 30
@export var jump_force = 700
@export var max_jumps = 2
var jump_count = 0

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 800:
			velocity.y = 800
	
	if is_on_floor():
		jump_count = 0
		jump_force = 700
	
	if jump_count == 1:
		jump_force = 500
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
		jump_count += 1
		
	var horizontal_direction = Input.get_axis("move_left","move_right")	
	velocity.x = speed * horizontal_direction
	move_and_slide()
	

