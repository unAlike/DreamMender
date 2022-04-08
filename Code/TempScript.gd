extends KinematicBody2D

onready var Player = owner.get_node("Player")
onready var Stop = get_parent().get_node("Stop")
var Radius = 100
var Sail = false
var Speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Player.global_position.distance_to($Start.global_position) <= Radius:
		Sail = true
	if Sail:
		global_position = lerp(global_position, Stop.global_position, delta/Speed)
