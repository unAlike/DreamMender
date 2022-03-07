extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var InputObjectList = []
var objectList = []
var lastPlayed = 0
var hexRotation = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	if InputObjectList.size()>0:
		for obj in InputObjectList:
			objectList.append([get_node(obj),get_node(obj).rotation_degrees])

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			for c in $Rift.get_children():
				print(c.name)
			if event.button_index == 1:
				RotateClockwise()
			else:
				RotateCounterClockwise()
		

 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for obj in objectList:
		var newloc = $Rift/Position2D.global_position + Vector2(cos(hexRotation), sin(hexRotation)) * ($Rift/Position2D.global_position-obj[0].global_position).length()
		obj[0].global_position = lerp(obj[0].global_position, newloc, .1)
		obj[0].rotation_degrees = lerp(obj[0].rotation_degrees, obj[1], .05)
	$Rift.rotation_degrees = lerp($Rift.rotation_degrees, hexRotation, .05)
		
func RotateClockwise():
	hexRotation += 120
	for obj in objectList:
		obj[1] += 120
func RotateCounterClockwise():
	hexRotation -= 120
	for obj in objectList:
		obj[1] -= 120
