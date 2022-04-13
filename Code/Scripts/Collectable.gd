extends Node2D

signal get_button

func _on_ButtonArea2D_body_entered(body):
	emit_signal("get_button")
	print("Collectable Acquired")
	queue_free()
