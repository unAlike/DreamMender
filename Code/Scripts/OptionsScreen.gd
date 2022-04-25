extends Control

func _ready():
	##$BackButton.grab_focus()
	pass

func _on_BackButton_pressed():
	queue_free()
