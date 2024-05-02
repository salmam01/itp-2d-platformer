extends CharacterBody2D

@export var speed = 800
@export var gravity = 30
@export var default_jump_force = 700
@export var reduced_jump_force = 600
@export var max_jumps = 2
@export var starting_position = Vector2(150,200)
var jump_force_state = default_jump_force
var jump_count = 0

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 800:
			velocity.y = 800
	
	if is_on_floor():
		jump_count = 0
		jump_force_state = default_jump_force
	
	#reduces mid-air jump
	if jump_count == 1:
		jump_force_state = reduced_jump_force
	
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		velocity.y = -default_jump_force
		jump_count += 1
		
	var horizontal_direction = Input.get_axis("move_left","move_right")	
	velocity.x = speed * horizontal_direction
	move_and_slide()
	
func _ready():
	# Set the starting position of the player
	position = starting_position  # Set the desired X and Y coordinates
	
# Teleport the player back to the starting position
func teleport_to_starting_position():
	position = starting_position
	
func _on_level_end_body_entered(body):
	teleport_to_starting_position()
