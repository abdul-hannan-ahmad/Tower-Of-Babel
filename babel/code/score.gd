extends TextEdit
@onready var cam = get_node("/root/GameScene/Camera2D")
@onready var player = get_node("/root/GameScene/player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "SCORE: " + str(player.score)
	position.y = cam.position.y - 450

