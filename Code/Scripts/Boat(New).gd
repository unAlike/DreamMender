extends KinematicBody2D

var lerpVal = 0
var moving = false

func _process(delta):
	if moving:
		lerpVal += delta / 1000
		global_position = lerp( get_node("fromPos").global_position, get_node("toPos").global_position, lerpVal)

func _on_CollisionDetector_body_entered(body):
	if body.name == "Player":
		moving = true
