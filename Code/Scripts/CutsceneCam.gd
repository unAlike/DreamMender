extends Node

var playerCam: Camera2D
var lerpCam: Camera2D
var sceneCam: Camera2D
var lerpTime = 0
var finished = false
# Called when the node enters the scene tree for the first time.
func _ready():
	playerCam = get_tree().current_scene.get_node("Player").get_node("Camera2D")
	lerpCam = get_node("LerpCam")
	sceneCam = get_node("SceneCam")
	pass # Replace with function body.



func _process(delta):
	if not finished:
		if get_node("CanvasLayer").Interacting:
			if lerpTime == 0:
				lerpCam.global_position = playerCam.global_position
				lerpCam.zoom = playerCam.zoom
				lerpCam.offset_h = playerCam.offset_h
				lerpCam.offset_v = playerCam.offset_v
				print("Ran One Time")
			playerCam.zoom = lerp(lerpCam.zoom, sceneCam.zoom, lerpTime)
			playerCam.offset_h = lerp(lerpCam.offset_h, sceneCam.offset_h, lerpTime)
			playerCam.offset_v = lerp(lerpCam.offset_v, sceneCam.offset_v, lerpTime)
			playerCam.global_position = lerp(lerpCam.global_position, sceneCam.global_position, lerpTime)
			if lerpTime < 1:
				lerpTime += delta
		elif not get_node("CanvasLayer").Interacting and not get_node("CanvasLayer").Interactable:
			playerCam.zoom = lerp(lerpCam.zoom, sceneCam.zoom, lerpTime)
			playerCam.offset_h = lerp(lerpCam.offset_h, sceneCam.offset_h, lerpTime)
			playerCam.offset_v = lerp(lerpCam.offset_v, sceneCam.offset_v, lerpTime)
			playerCam.global_position = lerp(lerpCam.global_position, sceneCam.global_position, lerpTime)
			if lerpTime > 0:
				lerpTime -= delta
			else:
				finished = true
				
