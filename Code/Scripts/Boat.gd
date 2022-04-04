extends Node2D

func _ready():
	pass

func _on_CollisionDetector_body_entered(body):
	print("Hello")
	$AnimationPlayer.current_animation = "Start"
	$AnimationPlayer.play()


func onEntered():
	print("Worked")
	$AnimationPlayer.play()


func _on_CollisionDetector_area_entered(area):
	print("Worked")
	$AnimationPlayer.play()
	pass # Replace with function body.
