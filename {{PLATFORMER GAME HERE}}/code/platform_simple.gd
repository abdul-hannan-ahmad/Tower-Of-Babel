extends AnimatableBody2D

signal player_touched

var should_emit_signal := true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and should_emit_signal == true:
		player_touched.emit()
		should_emit_signal = false
