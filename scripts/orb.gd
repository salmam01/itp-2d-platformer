extends Area2D

@export var void_level = 2100
@export var orb_visable = true
@export var health_orb_visable = true
@export var dash_orb_visable = true
@export var jump_orb_visable = true
@export var jump_orb_2_visable = true

func _on_player_free_orb():
	if orb_visable:
		position.y -= void_level
		orb_visable = false
func _on_player_show_orb():
	if !orb_visable:
		position.y += void_level
		orb_visable = true

func _on_player_free_health_orb():
	if health_orb_visable:
		position.y -= void_level
		health_orb_visable = false
func _on_player_show_health_orb():
	if !health_orb_visable:
		position.y += void_level
		health_orb_visable = true
	
func _on_player_free_dash_orb():
	if dash_orb_visable:
		position.y -= void_level
		dash_orb_visable = false
func _on_player_show_dash_orb():
	if !dash_orb_visable:
		position.y += void_level
		dash_orb_visable = true
	
func _on_player_free_jump_orb():
	if jump_orb_visable:
		position.y -= void_level
		jump_orb_visable = false
func _on_player_show_jump_orb():
	if !jump_orb_visable:
		position.y += void_level
		jump_orb_visable = true

func _on_player_free_jump_orb_2():
	if jump_orb_2_visable:
		position.y -= void_level
		jump_orb_2_visable = false
func _on_player_show_jump_orb_2():
	if !jump_orb_2_visable:
		position.y += void_level
		jump_orb_2_visable = true
