extends Node2D

func _ready():
	pass

func _on_CollisionDetector_body_entered(body):
	$AnimationPlayer.play()
