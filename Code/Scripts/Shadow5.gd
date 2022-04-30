extends "res://Scripts/Dialogue.gd"

var Fade = false
var Fade2 = false
var Fade3 = false
export var FadeSpeed = .025

onready var NPC1 = get_parent().get_node("NPC")
onready var NPC2 = get_parent().get_node("NPC2")
onready var NPC3 = get_parent().get_node("NPC3")
onready var NPC4 = get_parent().get_node("NPC4")
onready var NPC5 = get_parent().get_node("NPC5")
onready var NPC6 = get_parent().get_node("NPC6")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Fade:
		NPC1.modulate.a = lerp(NPC1.modulate.a, 0, FadeSpeed)
		NPC4.modulate.a = lerp(NPC4.modulate.a, 0, FadeSpeed)
	if Fade2:
		NPC2.modulate.a = lerp(NPC2.modulate.a, 0, FadeSpeed)
		NPC5.modulate.a = lerp(NPC5.modulate.a, 0, FadeSpeed)
	if Fade3:
		NPC3.modulate.a = lerp(NPC3.modulate.a, 0, FadeSpeed)
		NPC6.modulate.a = lerp(NPC6.modulate.a, 0, FadeSpeed)

func Message():
#	if Tracker == 1:
#		Text = Text2
#	elif Tracker == 2:
#		Text = Text3
	Box.visible = true
	Dialogue.text = Text[At]
	Dialogue.visible_characters = 0
	Duration.start()
	if At == Text.size() - 1:
		Tracker += 1
		if Tracker == 1:
			Text = Text2
			Fade = true
		elif Tracker == 2:
			Text = Text3
			Fade2 = true
		elif Tracker == 3:
			Fade3 = true
			Interactable = false
