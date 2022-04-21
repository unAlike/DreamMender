extends Control

func _ready():
	##$MenuButtons/StartButton.grab_focus()
	pass

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/MainLevel.tscn")

func _on_OptionsButton_pressed():
	var options = load("res://Scenes/OptionsScreen.tscn").instance()
	get_tree().current_scene.add_child(options)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/EndGameScreen.tscn")
