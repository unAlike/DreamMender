extends Node2D

export(PackedScene) var NeedleScene
export var Cooldown = 2
var yellowSpool = false
var redSpool = false
var blueSpool = false
onready var Flip = get_tree().get_current_scene().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Annoying
	yellowSpool = false
	redSpool = false
	blueSpool = false
	$Timer.set_wait_time(Cooldown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node2D.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("left_click") and $Timer.get_time_left() == 0 and yellowSpool:
		Throw()
		$Timer.start()
	
	# For testing purposes press "P" to unlock all spools
	if Input.is_action_just_pressed("Cheat"):
		yellowSpool = true
		redSpool = true
		blueSpool = true
		print("Unlocked all spools")

func Throw():
	var Needle = NeedleScene.instance()
	get_tree().current_scene.add_child(Needle)
	Needle.global_position = $Node2D/Position2D.global_position
	Needle.Velocity = get_global_mouse_position() - Needle.global_position
	if Flip.flipped:
		Needle.rotate((get_angle_to(get_global_mouse_position()) + PI + (PI/2))*(-1))
	else:
		Needle.rotate(get_angle_to(get_global_mouse_position()) + (PI/2))
