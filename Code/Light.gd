extends Node2D

var OldC : Color
var OldS = Vector2.ZERO
var toClose = false
var toOpen = false

func _ready():
	OldC = $Light2D.color
	OldS = $Light2D.scale

func _process(delta):
	if Input.is_action_just_pressed("swap"):
		if toClose == false:
			toClose = true
			toOpen = false
		else:
			toOpen = true
			toClose = false
	if toClose:
		$Light2D.scale = lerp($Light2D.scale, Vector2(.1,.1), .05)
		#$Light2D.color.a = lerp($Ligth2D.color.a, 0, .1)
	if toOpen:
		$Light2D.scale = lerp($Light2D.scale, OldS, .05)
		#$Light2D.color.a = lerp($Ligth2D.color.a, 1, .1)
