extends "res://Scripts/Rift.gd"

export var fromRotation = 0
export var toRotation = 120

# Called when the node enters the scene tree for the first time.
func _ready():
	if InputObjectList.size()>0:
		for obj in InputObjectList:
			objectList.append(get_node(obj))

 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftOpen:
		for obj in objectList:
			obj.rotation_degrees += 1
		$Rift.rotation_degrees += 1
	else:
		for obj in objectList:
			obj.rotation_degrees -= 1
		$Rift.rotation_degrees -=1

#func RotateClockwise():
#	hexRotation += 120
#	for obj in objectList:
#		obj[1] += 120
#func RotateCounterClockwise():
#	hexRotation -= 120
#	for obj in objectList:
#		obj[1] -= 120
