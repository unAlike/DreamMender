extends Node2D

# All Rift Variables
export var InputObjectList = []
export var riftOpen = true
export var riftUnstable = false
var riftTimer = 0
export var unstableTimer = 5
var objectList = []
var lastPlayed = 0

class Platform:
	var object
	var startPos
	var toPos
	func _init(obj, start, to):
		object = obj
		startPos = start
		toPos = to

# Plan to have the player click the rift to DoSomething()
func _process(delta):
	if Input.is_action_just_pressed("swap"):
		Move()

func Move():
	pass
