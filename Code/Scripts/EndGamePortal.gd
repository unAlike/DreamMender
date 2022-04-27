extends Area2D

export var Wait = 5
export var GrowSpeed = .005
export var GrowSize = 5
var Grow = false

func _ready():
	$Timer.set_wait_time(Wait)

func _process(delta):
	if Grow:
		$Light.scale = lerp($Light.scale, Vector2(GrowSize,GrowSize), GrowSpeed)

func _on_EndGamePortal_body_entered(body):
	if body.name == "Needle":
		body.queue_free()
		$Timer.start()
		Grow = true

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/EndGameScreen.tscn")
