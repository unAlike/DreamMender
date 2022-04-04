extends "res://Scripts/Rift.gd"

export var fromRotation = 0
export var toRotation = 120

# Called when the node enters the scene tree for the first time.
func _ready():
	if InputObjectList.size()>0:
		for obj in InputObjectList:
			objectList.append([get_node(obj),get_node(obj).rotation_degrees])

 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftOpen:
		for obj in objectList:
			var newloc = $Rift/Position2D.global_position + Vector2(cos(toRotation), sin(toRotation)) * ($Rift/Position2D.global_position-obj[0].global_position).length()
			obj[0].global_position = lerp(obj[0].global_position, newloc, .1)
			obj[0].rotation_degrees = lerp(obj[0].rotation_degrees, obj[1], .05)
			obj[0].rotation_degrees -= .3
		$Rift.rotation_degrees = lerp($Rift.rotation_degrees, toRotation, .05)
	else:
		for obj in objectList:
			var newloc = $Rift/Position2D.global_position + Vector2(cos(fromRotation), sin(fromRotation)) * ($Rift/Position2D.global_position-obj[0].global_position).length()
			obj[0].global_position = lerp(obj[0].global_position, newloc, .1)
			obj[0].rotation_degrees = lerp(obj[0].rotation_degrees, obj[1], .05)
			obj[0].rotation_degrees -= .3
		$Rift.rotation_degrees = lerp($Rift.rotation_degrees, fromRotation, .05)

#func RotateClockwise():
#	hexRotation += 120
#	for obj in objectList:
#		obj[1] += 120
#func RotateCounterClockwise():
#	hexRotation -= 120
#	for obj in objectList:
#		obj[1] -= 120
