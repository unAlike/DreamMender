extends Control

func _ready():
	##$BackButton.grab_focus()
	pass

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
