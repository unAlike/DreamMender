extends KinematicBody2D

export var Speed = 500
export var Velocity = Vector2.ZERO
export var Life = 2

func _ready():
	$Timer.set_wait_time(Life)
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var Collision = move_and_collide(Velocity.normalized() * delta * Speed)
	if Collision or $Timer.get_time_left() == 0:
		#print("You hit ",Collision.collider.name, " of ", Collision.collider.get_parent().name)
		queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "Obsticles":
		queue_free()
	if body in get_tree().get_nodes_in_group("killNeedle"):
		queue_free()
