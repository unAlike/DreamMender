extends Node2D

signal get_button

func _on_ButtonArea2D_body_entered(body):
	if body.name == "Player":
		get_tree().get_current_scene().get_node("Player/Progress/Control").Collected()
		emit_signal("get_button")
		queue_free()
