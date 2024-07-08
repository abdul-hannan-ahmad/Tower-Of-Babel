extends RigidBody2D

@export var jump_force := 700.0


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		linear_velocity.y -= jump_force
