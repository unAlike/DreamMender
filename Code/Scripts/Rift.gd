extends Area2D

export (Array, NodePath) var InputObjectList = []
export var riftActive = true
export var riftUnstable = false
export var Time = 5
export var speed = 1.0

var objectList = []
var lastPlayed = 0
var original = false
onready var riftTimer: Timer = get_node("riftTimer")

func _ready():
	riftTimer.set_wait_time(Time)
	original = riftActive

func _process(delta):
	# If rift is unstable, change rift state after each timeout
	if riftUnstable == true:
		if riftTimer.get_time_left() == 0:
			riftActive = !riftActive
			riftTimer.start()
	# If rift is stable & not in original state, change rift state after timeout
	else:
		if riftActive != original and riftTimer.get_time_left() == 0:
			if riftTimer.get_wait_time()>0.1:
				riftActive = !riftActive
				riftTimer.start()

	# For testing purposes press "SPACE" to Interact()
	if Input.is_action_just_pressed("swap"):
		Interact()

# Activates an inactive rift or resets the timer of an active one
func Interact():
	if riftUnstable:
		pass
	else:
		print("BOB")
		if riftActive == original:
			riftActive = !riftActive
		riftTimer.start()
