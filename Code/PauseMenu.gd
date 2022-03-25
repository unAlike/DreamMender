extends CanvasLayer


var Paused = false
var InControls = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and !InControls:
		$PauseMenu.visible = !$PauseMenu.visible
		get_tree().paused = !get_tree().paused
	if Input.is_action_just_pressed("ui_cancel") and InControls:
		$PauseMenu.visible = !$PauseMenu.visible
		$ControlsMenu.visible = !$ControlsMenu.visible
		InControls = !InControls

func _on_Resume_pressed():
	$PauseMenu.visible = !$PauseMenu.visible
	get_tree().paused = !get_tree().paused

func _on_Collections_pressed():
	pass

func _on_Controls_pressed():
	$PauseMenu.visible = !$PauseMenu.visible
	$ControlsMenu.visible = !$ControlsMenu.visible
	InControls = true

func _on_Save_pressed():
	pass # Replace with function body.

func _on_Load_pressed():
	pass # Replace with function body.

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
	get_tree().paused = !get_tree().paused
