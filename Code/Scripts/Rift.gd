extends Area2D

export var InputObjectList = []
export var riftOpen = true
export var riftUnstable = false
export var unstableTime = 5

var objectList = []
var lastPlayed = 0
var original = false
onready var riftTimer = get_node("riftTimer")
onready var unstableTimer = get_node("unstableTimer")

func _ready():
	riftTimer.set_wait_time(unstableTime)
	unstableTimer.set_wait_time(unstableTime)
	unstableTimer.start()
	original = riftOpen

func _process(delta):
	# If rift is unstable, change rift state after each timeout
	if riftUnstable == true:
		if unstableTimer.get_time_left() == 0:
			riftOpen = !riftOpen
			unstableTimer.start()
	# If rift is stable & not in original state, change rift state after timeout
	else:
		if riftOpen != original and riftTimer.get_time_left() == 0:
			riftOpen = !riftOpen

	# How Interact() is activated
	if Input.is_action_just_pressed("swap"):
		Interact()

# Activates an inactive rift or resets the timer of an active one
func Interact():
	if riftUnstable:
		unstableTimer.start()
	else:
		if riftOpen == original:
			riftOpen = !riftOpen
		riftTimer.start()
