extends KinematicBody2D

var lerpVal = 1

func _on_CollisionDetector_body_entered(body):
	global_position = lerp( get_node("fromPos").global_position, get_node("toPos").global_position, lerpVal)
