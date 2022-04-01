extends KinematicBody2D

var object
var fromPos
var toPos
func _init(obj, start, to):
	object = obj
	fromPos = start
	toPos = to
