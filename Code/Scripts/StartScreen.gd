extends Control
var gameScene = preload("res://Scenes/MainLevel.tscn")

func _ready():
	AudioServer.set_bus_volume_db(0,6)
	AudioServer.set_bus_volume_db(1,-15)
	AudioServer.set_bus_volume_db(2,-15)
	pass

func _on_StartButton_pressed():
	get_tree().change_scene_to(gameScene)

func _on_OptionsButton_pressed():
	var options = load("res://Scenes/OptionsScreen.tscn").instance()
	get_tree().current_scene.add_child(options)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/EndGameScreen.tscn")
