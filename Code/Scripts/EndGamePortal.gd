extends Area2D

func _on_EndGamePortal_body_entered(body):
	get_tree().change_scene("res://Scenes/EndGameScreen.tscn")
