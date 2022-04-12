extends Node2D

export(PackedScene) var NeedleScene
export var Cooldown = 2 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(Cooldown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node2D.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("left_click") and $Timer.get_time_left() == 0:
		Throw()
		$Timer.start()

func Throw():
	var Needle = NeedleScene.instance()
	get_tree().current_scene.add_child(Needle)
	Needle.global_position = $Node2D/Position2D.global_position
	Needle.Velocity = get_global_mouse_position() - Needle.global_position
	Needle.rotate(get_angle_to(get_global_mouse_position()) + (PI/2))
