extends KinematicBody2D

var lerpVal = 0
var moving = false
var fromPos
var toPos
var bobCounter =0
export var bob = 10
export var bobSpeed = 1

func _ready():
	fromPos = get_node("fromPos").global_position
	toPos = get_node("toPos").global_position

func _process(delta):
	bobCounter += delta*bobSpeed
	var y = fromPos.y+sin(bobCounter)*bob
	if moving:
		if lerpVal<1:
			lerpVal += delta/15
	global_position = Vector2(lerp(fromPos.x, toPos.x, lerpVal),y)

func _on_CollisionDetector_body_entered(body):
	if body.name == "Player":
		moving = true
