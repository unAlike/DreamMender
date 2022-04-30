extends Node

var playerCam: Camera2D
var lerpCam: Camera2D
var sceneCam: Camera2D
var lerpTime = 0
onready var finished = get_node("CanvasLayer")
var done = false
var lastTracker = 0
var zoomed = false

func _ready():
	playerCam = get_tree().current_scene.get_node("Player").get_node("Camera2D")
	lerpCam = get_node("LerpCam")
	sceneCam = get_node("SceneCam")

func _process(delta):
	if finished.Interacting and finished.InRadius:
		zoomed = true
		if lerpTime == 0:
			lerpCam.global_position = playerCam.global_position
			lerpCam.zoom = playerCam.zoom
			lerpCam.offset_h = playerCam.offset_h
			lerpCam.offset_v = playerCam.offset_v
		playerCam.zoom = lerp(lerpCam.zoom, sceneCam.zoom, lerpTime)
		playerCam.offset_h = lerp(lerpCam.offset_h, sceneCam.offset_h, lerpTime)
		playerCam.offset_v = lerp(lerpCam.offset_v, sceneCam.offset_v, lerpTime)
		playerCam.global_position = lerp(lerpCam.global_position, sceneCam.global_position, lerpTime)
		if lerpTime < 1:
			lerpTime += delta
	elif not finished.Interacting and finished.InRadius and zoomed:
		playerCam.zoom = lerp(lerpCam.zoom, sceneCam.zoom, lerpTime)
		playerCam.offset_h = lerp(lerpCam.offset_h, sceneCam.offset_h, lerpTime)
		playerCam.offset_v = lerp(lerpCam.offset_v, sceneCam.offset_v, lerpTime)
		playerCam.global_position = lerp(lerpCam.global_position, sceneCam.global_position, lerpTime)
		if lerpTime > 0:
			lerpTime -= delta
		else:
			zoomed = false
