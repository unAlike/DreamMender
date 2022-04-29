extends Node2D

export(PackedScene) var NeedleScene
export var Cooldown = 2
onready var Flip = get_tree().get_current_scene().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(Cooldown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Node2D.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("left_click") and $Timer.get_time_left() == 0 and Stats.getYellow():
		$Timer.start()
		get_parent().get_node("AnimationTree").set("parameters/conditions/throwing", true)
		get_parent().state_machine.travel("throw")
		if get_parent().state_machine.get_current_node() != "throw":
			yield(get_tree().create_timer(.05), "timeout")
			get_parent().get_node("AnimationTree").set("parameters/conditions/throwing", false)
	
	# Press "P" and "crouch" at the same time to unlock all spools
	if Input.is_action_just_pressed("Cheat") and Input.is_action_just_pressed("crouch"):
		Stats.setYellow(true)
		Stats.setRed(true)
		Stats.setBlue(true)
		get_tree().get_current_scene().get_node("Player/Progress/Control").Blue()
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
