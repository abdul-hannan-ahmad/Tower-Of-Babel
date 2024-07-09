extends Camera2D



@onready var timer = 0
@export var camSpeed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_child(0)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= camSpeed * delta
	if timer.time_left <= 0:
		print("speed up")
		camSpeed += 10
		timer.start()

	
