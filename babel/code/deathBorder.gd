extends Area2D

@onready var death_menu: Control = $"../DeathMenu"


func _on_body_entered(body:Node2D):
	if body.name == "player":
		death_menu.show()
