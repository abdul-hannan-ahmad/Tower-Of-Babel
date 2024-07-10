extends Node2D



@onready var player = get_parent().get_node("player")
# Called when the
var segments = [
	preload("res://scenes/sect_1.tscn"),
	preload("res://scenes/sect_2.tscn"),
	preload("res://scenes/sect_3.tscn"),
	preload("res://scenes/sect_4.tscn"),
	preload("res://scenes/sect_5.tscn"),
	preload("res://scenes/sect_6.tscn"),
	preload("res://scenes/sect_7.tscn"),
	preload("res://scenes/sect_8.tscn"),
	preload("res://scenes/sect_9.tscn"),
	preload("res://scenes/sect_10.tscn"),

]
var rng = RandomNumberGenerator.new()
@export var hight = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_block()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if player.position.y <= hight + 3000:
		spawn_block()

func spawn_block():
	var number = rng.randi_range(0, segments.size()-1)
	print(number)
	var block = segments[number].instantiate()
	block.position = Vector2(0, hight)
	add_child(block)
	hight -= 650
