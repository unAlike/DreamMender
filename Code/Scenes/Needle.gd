extends KinematicBody2D

export var Speed = 500
export var Velocity = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var Collision = move_and_collide(Velocity.normalized() * delta * Speed)
	if Collision:
		print("You hit ",Collision.collider.name, " of ", Collision.collider.get_parent().name)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
