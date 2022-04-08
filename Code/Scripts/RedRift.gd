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
	if riftActive:
		$Rift/InnerHex.animation = "Open"
		for obj in objectList:
			obj.rotation_degrees += 1
		$Rift.rotation_degrees += 1
	else:
		$Rift/InnerHex.animation = "Closed"
		for obj in objectList:
			obj.rotation_degrees -= 1
		$Rift.rotation_degrees -=1


func _on_Rift_body_entered(body):
	if body.name == "Needle":
		body.queue_free()
		Interact()
