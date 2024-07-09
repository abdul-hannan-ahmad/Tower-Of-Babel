extends CharacterBody2D

const JUMP_FORCE := -550.0
const SPEED := 350.0
const DASH_SPEED := 1500.0
@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_double_jumped := false


func _process(delta: float) -> void:
	handle_movement(delta)
	
	
func handle_movement(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("Crash"):
		velocity.y = 5000

	if Input.is_action_just_pressed("jump") and (is_on_floor() or has_double_jumped == false):
		if is_on_floor():
			has_double_jumped = false
		elif has_double_jumped == false:
			has_double_jumped = true
			
		velocity.y = JUMP_FORCE
		print("JUMPED")
		
	var direction := Input.get_axis("move_left", "move_right")
	
	velocity.x = move_toward(velocity.x, direction * SPEED, 5000 * delta)
	if Input.is_action_just_pressed("Dash"):
		print("DASH")
		velocity.x = DASH_SPEED * direction
	move_and_slide()
