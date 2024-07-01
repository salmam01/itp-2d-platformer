extends CharacterBody2D

@export var speed = 800
@export var gravity = 30
@export var default_jump_force = 700
@export var reduced_jump_force = 500
@export var max_jumps = 2
@export var starting_position = Vector2(150,200)
@export var orbs = 0
@export var max_lives = 9
@export var current_lives = 3
@export var default_lives = 3
@export var max_jump_boosts = 3
@export var current_jump_boosts = 0
@export var max_speed_boosts = 3
@export var current_speed_boosts = 0
@onready var Lives_UI = $UI
@onready var life_container = $GUI/HBoxContainer
var jump_force_state = default_jump_force
var jump_count = 0

@onready var Tail_Counter = $GUI/TailCounter

@export var current_direction = 0 #0 right, 1 left
@onready var _body_right = $PlayerBodyRight
@onready var _body_left = $PlayerBodyLeft
@onready var _tail1_right = $Tail1Right
@onready var _tail1_left = $Tail1Left
@onready var _tail2_right = $Tail2Right
@onready var _tail2_left = $Tail2Left
@onready var _tail3_right = $Tail3Right
@onready var _tail3_left = $Tail3Left
@onready var _tail4_right = $Tail4Right
@onready var _tail4_left = $Tail4Left
@onready var _tail5_right = $Tail5Right
@onready var _tail5_left = $Tail5Left
@onready var _tail6_right = $Tail6Right
@onready var _tail6_left = $Tail6Left
@onready var _tail7_right = $Tail7Right
@onready var _tail7_left = $Tail7Left
@onready var _tail8_right = $Tail8Right
@onready var _tail8_left = $Tail8Left
@onready var _tail9_right = $Tail9Right
@onready var _tail9_left = $Tail9Left
@onready var invulnerability = $Invulnerability
@onready var effects_animation = $EffectsAnimation

@onready var _tails_right = [
	_tail1_right, _tail2_right, _tail3_right, 
	_tail4_right, _tail5_right, _tail6_right, 
	_tail7_right, _tail8_right, _tail9_right
	]
@onready var _tails_left = [
	_tail1_left, _tail2_left, _tail3_left, 
	_tail4_left, _tail5_left, _tail6_left, 
	_tail7_left, _tail8_left, _tail9_left
]

signal show_orb

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
		if current_direction == 0:
			toggle_body_visability("left", "right")
			if jump_count == 1:
				_body_right.stop()
				stop_tail_animation()
			_body_right.play("jump")
			toggle_tail_animation("right", "jump")
		else:
			toggle_body_visability("right", "left")
			if jump_count == 1:
				_body_left.stop()
				stop_tail_animation()
			_body_left.play("jump")
			toggle_tail_animation("left", "jump")
		jump_count += 1
		
	if Input.is_action_pressed("dash") && current_speed_boosts > 0:
		current_speed_boosts -= 1
		dash()
		
	if Input.is_action_pressed("boosted_jump") && current_jump_boosts > 0:
		current_jump_boosts -= 1
		jump_boost()
		
	var horizontal_direction = Input.get_axis("move_left","move_right")	
	velocity.x = speed * horizontal_direction
	move_and_slide()
	
	if Input.is_action_pressed("move_right"):
		current_direction = 0
		toggle_body_visability("left", "right")
		toggle_tail_visability("left", "right")
		if jump_count == 0:
			_body_right.play("run")
			toggle_tail_animation("right", "run")
	elif Input.is_action_pressed("move_left"):
		current_direction = 1
		toggle_body_visability("right", "left")
		toggle_tail_visability("right", "left")
		if jump_count == 0:
			_body_left.play("run")
			toggle_tail_animation("left", "run")
	else:
		if current_direction == 0:
			toggle_body_visability("left", "right")
			if jump_count == 0:
				_body_right.play("idle")
				toggle_tail_animation("right", "idle")
		else:
			toggle_body_visability("right", "left")
			if jump_count == 0:
				_body_left.play("idle")
				toggle_tail_animation("left", "idle")
	
	Lives_UI.text = "Lives: " + str(current_lives)
	Lives_UI.text += "\nOrbs: " + str(orbs)
	Lives_UI.text += "\nSpeed Boosts: " + str(current_speed_boosts) + "  (Shift)"
	Lives_UI.text += "\nJump Boosts: " + str(current_jump_boosts) + "  (F)"
	
func _ready():
	# Set the starting position of the player
	position = starting_position  # Set the desired X and Y coordinates
	update_life_gui()
	toggle_body_visability("left", "right")
	toggle_tail_visability("left", "right")
	
func update_life_gui():
	if current_lives <= max_lives:
		Tail_Counter.play(GlobalVariables.current_counter_style+str(current_lives))
	for i in range(max_lives):
		var life_icon = life_container.get_child(i)
		if i == current_lives - 1:  # Show only the current_lives-th TextureRect
			life_icon.visible = true
		else:
			life_icon.visible = false

func lose_life():
	if current_lives > 0:
		current_lives -= 1
		update_life_gui()
		if current_direction == 0:
			toggle_tail_visability("left", "right")
		else:
			toggle_tail_visability("right", "left")
	if current_lives == 0:
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")

func gain_life():
	if current_lives < max_lives:
		current_lives += 1
		update_life_gui()
		if current_direction == 0:
			toggle_tail_visability("left", "right")
		else:
			toggle_tail_visability("right", "left")

# Teleport the player back to the starting position
func teleport_to_starting_position():
	position = starting_position
	
func _on_level_end_body_entered(body): 
	print("Level end triggered by body: ", body.name)  # Debugging print
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/victory_screen.tscn")

func _on_void_body_entered(body): #falling off level
	lose_life()
	reset_orbs()
	teleport_to_starting_position()

func _on_orb_body_entered(body):
	orbs += 1
	update_life_gui()
	
func _on_health_orb_body_entered(body):
	if(current_lives < max_lives):
		gain_life()

func _on_dash_orb_body_entered(body):
	if Input.is_action_pressed("pick_up") && current_speed_boosts != max_speed_boosts:
		current_speed_boosts += 1
	else:
		dash()

func _on_jump_orb_body_entered(body):
	if Input.is_action_pressed("pick_up") && current_jump_boosts != max_jump_boosts:
		current_jump_boosts += 1
	else:
		jump_boost()

func _on_spike_body_entered(body):
	if(body.name == "Player"):
		if(invulnerability.is_stopped()):
			lose_life()
			invulnerability.start()
			effects_animation.play("damage")
			effects_animation.queue("flash")

func _on_invulnerability_timeout():
	effects_animation.play("RESET")

func reset_orbs():
	emit_signal("show_orb")

func reset_level():
		teleport_to_starting_position()
		current_lives = default_lives
		update_life_gui()
		reset_orbs()

func dash():
	speed = 1600
	var timer := get_tree().create_timer(2)
	timer.timeout.connect(func(): speed = 800)
	
func jump_boost():
	jump_count = 0
	default_jump_force = 1000
	reduced_jump_force = 750
	var timer := get_tree().create_timer(2)
	timer.timeout.connect(func(): default_jump_force = 700)
	timer.timeout.connect(func(): reduced_jump_force = 500)

func toggle_body_visability(start, end):
	if start == "left" && end == "right":
		if _body_left.visible == true:
			_body_left.visible = false
		if _body_right.visible == false:
			_body_right.visible = true
	elif start == "right" && end == "left":
		if _body_right.visible == true:
				_body_right.visible = false
		if _body_left.visible == false:
			_body_left.visible = true
			
func toggle_tail_visability(start, end):
	for t in range(0, current_lives):
		if start == "left" && end == "right":
			if _tails_left[t].visible == true:
				_tails_left[t].visible = false
			if _tails_right[t].visible == false:
				_tails_right[t].visible = true
		elif start == "right" && end == "left":
			if _tails_right[t].visible == true:
				_tails_right[t].visible = false
			if _tails_left[t].visible == false:
				_tails_left[t].visible = true
	for t in range(current_lives, 9):
		_tails_left[t].visible = false
		_tails_right[t].visible = false
	
func toggle_tail_animation(direction, animation):
	if direction == "right":
		for t in _tails_right:
			t.play(animation)
	if direction == "left":
		for t in _tails_left:
			t.play(animation)
func stop_tail_animation():
	for t in _tails_right:
		t.stop()
	for t in _tails_left:
		t.stop()
