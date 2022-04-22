extends "res://Scripts/Dialogue.gd"

var Fade = false
export var FadeSpeed = .025

onready var Sub = get_parent().get_node("NPC")
onready var Cam = get_parent().get_node("Camera2D")
var lerpTime = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Cutscene = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if InRadius and Interactable:
		if lerpTime<=1:
			lerpTime+=delta
		get_parent().get_node("LerpCam").zoom = lerp(PlayerCam.zoom, Cam.zoom, lerpTime)
		get_parent().get_node("LerpCam").global_position = lerp(PlayerCam.global_position, Cam.global_position, lerpTime)
		get_parent().get_node("LerpCam").current = true
	elif !Interacting:
		if lerpTime>=0:
			lerpTime-=delta
		else:
			PlayerCam.current = true
		get_parent().get_node("LerpCam").zoom = lerp(PlayerCam.zoom, Cam.zoom, lerpTime)
		get_parent().get_node("LerpCam").global_position = lerp(PlayerCam.global_position, Cam.global_position, lerpTime)
		get_parent().get_node("LerpCam").current = true
		
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
