extends Control

func _ready():
	$MenuButtons/StartButton.grab_focus()

func _on_StartButton_pressed():
	get_tree().change_scene("res://MainLevel.tscn")

func _on_LoadButton_pressed():
	var next_level_resource = load("res://MainLevel.tscn")
	var next_level = next_level_resource.instance()
	next_level.load_saved_game = true
	get_tree().root.call_deferred("add_child", next_level)
	queue_free()

func _on_OptionsButton_pressed():
	var options = load("res://Scenes/OptionsScreen.tscn").instance()
	get_tree().current_scene.add_child(options)

func _on_QuitButton_pressed():
	get_tree().quit()
