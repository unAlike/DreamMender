extends "res://Scripts/Dialogue.gd"

signal yellow_thread

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
	if At == 9:
		Spools.yellowSpool = true
		emit_signal("yellow_thread")
		get_parent().get_node("NPC").animation = "Idle"
