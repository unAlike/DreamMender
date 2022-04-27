extends "res://Scripts/Dialogue.gd"

var Fade = false
export var FadeSpeed = .025

onready var Sub = get_parent().get_node("NPC")

# Called when the node enters the scene tree for the first time.
func _ready():
	Moving = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Fade:
		Sub.modulate.a = lerp(Sub.modulate.a, 0, FadeSpeed)

func Message():
	if Tracker == 1:
		Text = Text2
	elif Tracker == 2:
		Text = Text3
	Box.visible = true
	Dialogue.text = Text[At]
	Dialogue.visible_characters = 0
	Duration.start()
	if At == Text.size() - 1:
		Tracker += 1
		if Tracker == 3:
			Fade = true
			Interactable = false
