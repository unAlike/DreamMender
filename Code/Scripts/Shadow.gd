extends "res://Scripts/Dialogue.gd"

var Fade = false
export var FadeSpeed = .025

onready var Sub = get_parent().get_node("NPC")
onready var Cam = get_parent().get_node("Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	Cutscene = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if InRadius and Interactable:
		Cam.current = true
	elif !Interacting:
		PlayerCam.current = true
	if Fade:
		Sub.modulate.a = lerp(Sub.modulate.a, 0, FadeSpeed)

func Message():
	Box.visible = true
	Dialogue.text = Text[At]
	Dialogue.visible_characters = 0
	Duration.start()
	if At == Text.size() - 1:
		Fade = true
		Interactable = false
