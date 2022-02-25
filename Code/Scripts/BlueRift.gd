extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var InputObjectList = []
export var riftOpen = true
var objectList = []
var lastPlayed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if InputObjectList.size()>0:
		for obj in InputObjectList:
			print(obj)
			var plat = Platform.new(get_node(obj),get_node(obj).position,$Rift/Position2D.global_position-($Rift/Position2D.global_position-get_node(obj).position).normalized()*200)
			objectList.append([plat,false])
	
	

 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if riftOpen:
		$Rift/Particles2D.emitting = true
		for obj in objectList:
			obj[0].object.position = lerp(obj[0].object.position, obj[0].startPos, delta)
		if lastPlayed == 0:
			$RiftOpen.playing = true
			$RiftClose.playing = false
			lastPlayed = 1
		
	else:
		$Rift/Particles2D.emitting = false
		for obj in objectList:
			obj[0].object.position = lerp( obj[0].object.position, obj[0].toPos, delta)
		if lastPlayed == 1:
			$RiftOpen.playing = false
			$RiftClose.playing = true
			lastPlayed = 0
class Platform:
	var object
	var startPos
	var toPos
	func _init(obj, start, to):
		object = obj
		startPos = start
		toPos = to
