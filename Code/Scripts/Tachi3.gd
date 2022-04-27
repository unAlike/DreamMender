extends "res://Scripts/Dialogue.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Message():
	if Tracker == 1:
		Text = Text2
	Box.visible = true
	Dialogue.text = Text[At]
	Dialogue.visible_characters = 0
	Duration.start()
	if At == 7:
		Stats.setBlue(true)
		Prog.Blue()
		get_parent().get_node("NPC").animation = "Idle"
		get_parent().get_node("NPC2").animation = "Idle"
	if At == Text.size() - 1:
		Tracker += 1
		if Tracker == 2:
			Interactable = false
