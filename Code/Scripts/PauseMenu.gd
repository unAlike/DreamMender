extends CanvasLayer

var Paused = false
var InControls = false
var InSound = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$PauseMenu/Count.text = str(get_parent().pickupCount," / ",get_parent().collectableCount)
		if Input.is_action_just_pressed("ui_cancel") and InControls:
			$PauseMenu.visible = !$PauseMenu.visible
			$ControlsMenu.visible = !$ControlsMenu.visible
			InControls = false
		elif Input.is_action_just_pressed("ui_cancel") and InSound:
			$PauseMenu/VBoxContainer.visible = true
			$"PauseMenu/Sound Sliders".visible = false
			InSound = false
		else:
			$PauseMenu.visible = !$PauseMenu.visible
			get_tree().paused = !get_tree().paused

func _on_Resume_pressed():
	$PauseMenu.visible = !$PauseMenu.visible
	get_tree().paused = !get_tree().paused

func _on_Controls_pressed():
	$PauseMenu.visible = !$PauseMenu.visible
	$ControlsMenu.visible = !$ControlsMenu.visible
	InControls = true

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
	get_tree().paused = !get_tree().paused

func _on_Sound_pressed():
	$PauseMenu.get_node("VBoxContainer").set_visible(false)
	$PauseMenu.get_node("Sound Sliders").set_visible(true)
	InSound = true
	
func _on_BackBtn_pressed():
	$PauseMenu.get_node("VBoxContainer").set_visible(true)
	$PauseMenu.get_node("Sound Sliders").set_visible(false)
	InSound = false

func _on_Back_pressed():
	$PauseMenu.visible = !$PauseMenu.visible
	$ControlsMenu.visible = !$ControlsMenu.visible
	InControls = false

func _on_MainSlider_value_changed(val):
	for s in get_tree().get_nodes_in_group("sound"):
		if s in get_tree().get_nodes_in_group("music"):
			s.volume_db = (get_node("PauseMenu/Sound Sliders/Music Slider").value * (val/100)) -60
		if s in get_tree().get_nodes_in_group("sfx"):
			s.volume_db = -60 + (get_node("PauseMenu/Sound Sliders/FXSlider").value * (val/100)) -60

func _on_Music_Slider_value_changed(val):
	for s in get_tree().get_nodes_in_group("music"):
		s.volume_db =  (val*(get_node("PauseMenu/Sound Sliders/MainSlider").value/100)) - 60

func _on_FXSlider_value_changed(val):
	for s in get_tree().get_nodes_in_group("sfx"):
		s.volume_db = (val*(get_node("PauseMenu/Sound Sliders/MainSlider").value/100)) - 60
