extends Control
var gameScene = preload("res://Scenes/MainLevel.tscn")

func _ready():
	AudioServer.set_bus_volume_db(0,6)
	AudioServer.set_bus_volume_db(1,-15)
	AudioServer.set_bus_volume_db(2,-15)
	get_node("Sound Sliders/MainSlider").value = 6
	get_node("Sound Sliders/MainSlider").value = -15
	get_node("Sound Sliders/MainSlider").value = -15
	get_node("MenuButtons").visible = true
	get_node("Sound Sliders").visible = false
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

func _on_SoundButton_pressed():
	get_node("Sound Sliders").visible = true
	get_node("MenuButtons").visible = false
	pass
	
func _on_MainSlider_value_changed(val):
	if val == get_node("Sound Sliders/MainSlider").min_value:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0,val)

func _on_Music_Slider_value_changed(val):
	if val == get_node("Sound Sliders/Music Slider").min_value:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)
		AudioServer.set_bus_volume_db(1,val)
	
func _on_FXSlider_value_changed(val):
	if val == get_node("Sound Sliders/FXSlider").min_value:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)
		AudioServer.set_bus_volume_db(2,val)
	
func _on_BackBtn_pressed():
	get_node("Sound Sliders").visible = false
	get_node("MenuButtons").visible = true
