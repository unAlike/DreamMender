extends CanvasLayer


var Paused = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$PauseMenu.visible = !$PauseMenu.visible
		get_tree().paused = !get_tree().paused

func _on_Resume_pressed():
	$PauseMenu.visible = !$PauseMenu.visible
	get_tree().paused = !get_tree().paused

func _on_Collections_pressed():
	pass

func _on_Controls_pressed():
	pass # Replace with function body.

func _on_Save_pressed():
	pass # Replace with function body.

func _on_Load_pressed():
	pass # Replace with function body.

func _on_MainMenu_pressed():
	pass # Replace with function body.
