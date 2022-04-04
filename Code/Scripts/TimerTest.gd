extends Node2D

onready var Time = get_node("Timer")
export var Wait = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	Time.set_wait_time(Wait)
	Time.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Time.get_time_left())
	if Time.get_time_left() == 0:
		print("Timer has stopped")
		Time.start()
