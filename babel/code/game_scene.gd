extends Node2D

@onready var death_menu: Control = $Camera2D/DeathMenu


func _ready() -> void:
	death_menu.hide()
