extends "res://Scripts/Dialogue.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Message():
	Box.visible = true
	Dialogue.text = Text[At]
	Dialogue.visible_characters = 0
	Duration.start()