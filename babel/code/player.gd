extends CharacterBody2D

const JUMP_FORCE := -850.0  # The force applied when jumping
const SPEED := 400.0  # The movement speed
const DASH_SPEED := 1500.0  # The speed when dashing
@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")  # The gravity value
@onready var timer = $coyote  # Timer node for coyote time
@onready var flap = $wing  # the wing sound fx
@onready var crash = $crash  # the crash sound fx
@onready var jump = $jump  # the jump sound fx
@onready var dash = $dash  # the dash sound fx
var has_double_jumped := false  # Flag to track if double jump is available
var coyote = true  # Flag to track if coyote time is active
var justJumped = false  # Flag to track if the character just jumped
var counter  = 0  # Counter for tracking coyote time duration
var sprite
var score = 0
func _ready():
	sprite = get_child(0)
	timer.stop()  # Stop the timer when the scene is ready

func _process(delta: float) -> void:
	handle_movement(delta)  # Handle character movement
	score = int((global_position.y * -1) + 519)

func handle_movement(delta: float) -> void:
	if is_on_floor():
		has_double_jumped = false  # Reset double jump flag when character is on the floor
		justJumped = false  # Reset justJumped flag when character is on the floor
		counter = 0  # Reset coyote time counter
		timer.stop()  # Stop the timer
		timer.wait_time = 0.1   # Set the wait time for coyote time

	if not is_on_floor() and counter < 1:
		counter += 1  # Increment the counter when character is not on the floor
		timer.start()  # Start the timer

	if timer.time_left > 0 and is_on_floor() == false and justJumped == false:
		coyote = true  # Enable coyote time if timer is active and character is not on the floor
	elif timer.time_left <= 0:
		coyote = false  # Disable coyote time if timer is not active
		timer.stop()  # Stop the timer

	if not is_on_floor():
		velocity.y += gravity * delta  # Apply gravity when character is not on the floor

	if Input.is_action_just_pressed("Crash"):
		velocity.y = 5000  # Apply a high upward force when "Crash" action is pressed
		is_on_floor()  # Check if the character is on the floor
		crash.play()  # Play the crash sound effect

	if Input.is_action_just_pressed("jump") and (is_on_floor() or has_double_jumped == false or coyote == true):
		if is_on_floor():
			jump.play()  # Play the jump sound effect
			has_double_jumped = false  # Reset double jump flag when character is on the floor
		elif not is_on_floor() and has_double_jumped == false and coyote == true:

			jump.play()  # Play the jump sound effect
			has_double_jumped = false  # Set double jump flag if coyote time is active
		else:
			flap.play()  # Play the flap sound effect
			has_double_jumped = true  # Set double jump flag if character is not on the floor

		velocity.y = JUMP_FORCE  # Apply jump force
		print("JUMPED")  # Print "JUMPED" message
		justJumped = true  # Set justJumped flag
	var direction := Input.get_axis("move_left", "move_right")  # Get the input direction
	if direction != 0 and direction != -1:
		sprite.scale.x = 1
	elif direction == -1:
		sprite.scale.x = -1
  # Flip the sprite based on the input direction
	velocity.x = move_toward(velocity.x, direction * SPEED, 5000 * delta)  # Move the character horizontally
	if Input.is_action_just_pressed("Dash"):
		print("DASH")  # Print "DASH" message
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
			dash.play()  # Play the dash sound effect
		velocity.x = DASH_SPEED * direction  # Apply dash speed
	print(direction)
	move_and_slide()  # Move and slide the character
