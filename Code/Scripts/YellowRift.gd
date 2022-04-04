extends "res://Scripts/Rift.gd"

var lerpVal = 1
var platform
var oldScale = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _init():
	platform = load("res://Scripts/Platform.gd")

func _ready():
	oldScale = $Light2D.scale
	if InputObjectList.size()>0:
		for obj in InputObjectList:
			var plat = platform.new(get_node(obj),get_node(obj).get_node("fromPos").global_position,get_node(obj).get_node("toPos").global_position)
			objectList.append(plat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftOpen == false:
		$Rift/Particles2D.emitting = false
		$Light2D.scale = lerp($Light2D.scale, Vector2.ZERO, lerpVal)
		#print(str(objectList))
		for obj in objectList:
			obj.object.global_position = lerp(obj.fromPos, obj.toPos, lerpVal)
		if lerpVal < 1:
			lerpVal += delta/speed
	elif riftOpen == true:
		$Rift/Particles2D.emitting = true
		$Light2D.scale = lerp($Light2D.scale, oldScale, lerpVal)
		for obj in objectList:
			obj.object.global_position = lerp( obj.fromPos, obj.toPos, lerpVal)
		if lerpVal > 0:
			lerpVal -= delta/speed
	#print(lerpVal)
