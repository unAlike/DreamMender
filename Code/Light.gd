extends Node2D

var OldC : Color
var OldS = Vector2.ZERO
export var isActive = false

func _ready():
	OldC = $Light2D.color
	OldS = $Light2D.scale

func _process(delta):
	if Input.is_action_just_pressed("swap"):
		isActive = !isActive
	if !isActive:
		$Light2D.scale = lerp($Light2D.scale, Vector2(.1,.1), .05)
	elif isActive:
		$Light2D.scale = lerp($Light2D.scale, OldS, .05)
