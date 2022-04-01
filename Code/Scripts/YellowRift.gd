extends "res://Scripts/Rift.gd"

class Platform:
	var object
	var startPos
	var toPos
	func _init(obj, start, to):
		object = obj
		startPos = start
		toPos = to

# Called when the node enters the scene tree for the first time.
func _ready():
	if InputObjectList.size()>0:
		for obj in InputObjectList:
			var plat = Platform.new(get_node(obj),get_node(obj).position,$Rift/Position2D.global_position-($Rift/Position2D.global_position-get_node(obj).position).normalized()*800)
			objectList.append([plat,false])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftOpen == false:
		$Rift/Particles2D.emitting = false
		for obj in objectList:
			obj[0].object.position = lerp(obj[0].object.position, obj[0].toPos, delta)
#			obj[0].object.move_and_slide_with_snap(lerp(obj[0].object.position, obj[0].toPos, delta), Vector2.DOWN*32)
		if lastPlayed == 0:
			lastPlayed = 1
	elif riftOpen == true:
		$Rift/Particles2D.emitting = true
		for obj in objectList:
			obj[0].object.position = lerp( obj[0].object.position, obj[0].startPos, delta)
		if lastPlayed == 1:
			lastPlayed = 0
