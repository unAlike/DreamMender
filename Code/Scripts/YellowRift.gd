extends "res://Scripts/Rift.gd"

var lerpVal = 1
var platform

# Called when the node enters the scene tree for the first time.
func _init():
	platform = load("res://Scripts/Platform.gd")

func _ready():
	if InputObjectList.size()>0:
		for obj in InputObjectList:
			var plat = platform.new(get_node(obj),get_node(obj).get_node("fromPos").global_position,get_node(obj).get_node("toPos").global_position)
			objectList.append(plat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftOpen == false:
		$Rift/Particles2D.emitting = false
		print(str(objectList))
		for obj in objectList:
			obj.object.global_position = lerp(obj.fromPos, obj.toPos, lerpVal)
		if lerpVal < 1:
			lerpVal += delta/speed
	elif riftOpen == true:
		$Rift/Particles2D.emitting = true
		for obj in objectList:
			obj.object.global_position = lerp( obj.fromPos, obj.toPos, lerpVal)
		if lerpVal > 0:
			lerpVal -= delta/speed
	
	print(lerpVal)
