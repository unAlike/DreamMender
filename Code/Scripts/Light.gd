extends "res://Scripts/Rift.gd"

var oldScale = Vector2.ZERO
var isActive = false

func _ready():
	oldScale = $Light2D.scale
	isActive = !riftOpen

func _process(delta):
	if Input.is_action_just_pressed("swap"):
		isActive = !isActive
	if !isActive:
		$Light2D.scale = lerp($Light2D.scale, Vector2(.1,.1), .05)
	elif isActive:
		$Light2D.scale = lerp($Light2D.scale, oldScale, .05)
