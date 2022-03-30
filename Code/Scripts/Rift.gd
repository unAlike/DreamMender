extends Area2D

# All Rift Variables
export var InputObjectList = []
export var riftOpen = true
export var riftUnstable = false
export var unstableTime = 5

var objectList = []
var lastPlayed = 0
onready var riftTimer : Timer = get_node("Timer")
onready var unstableTimer : Timer = get_node("Timer")

# Plan to have the player click the rift to DoSomething()
func _process(delta):
	if !riftUnstable:
		if riftTimer.get_time_left()<=0:
			riftOpen = false
	else:
		if riftOpen and unstableTimer.get_time_left()<=0:
			unstableTimer.start(unstableTime)
			riftOpen = false
		elif !riftOpen and unstableTimer.get_time_left()<=0:
			unstableTimer.start(unstableTime)
			riftOpen = true
	

func Interact():
	if !riftOpen:
		if !riftUnstable:
			if unstableTime > 0:
				riftTimer.start(unstableTime)
				riftOpen = true
			else:
				riftOpen = true
	else:
		if unstableTime > 0:
			riftTimer.start(unstableTime)
