extends Node2D

signal get_button
var bobTime = 0
export var bobDistance = 10
export var bobSpeed = 5

func _process(delta):
	bobTime += delta*bobSpeed
	$ButtonSprite.position.y = sin(bobTime)*bobDistance
	$ButtonArea2D.position.y = $ButtonSprite.position.y
func _on_ButtonArea2D_body_entered(body):
	if body.name == "Player":
		get_tree().get_current_scene().get_node("Player/Progress/Control").Collected()
		emit_signal("get_button")
		queue_free()
