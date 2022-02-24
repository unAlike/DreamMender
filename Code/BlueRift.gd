extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var objectList = []
export var riftOpen = true
# Called when the node enters the scene tree for the first time.
func _ready():
	if objectList.size()>0:
		for obj in objectList:
			objectList.remove(obj)
			objectList.append([obj,false])
	if $Platforms.get_child_count() > 0:
		for c in $Platforms.get_children():
			objectList.append([c,false])
	


 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftOpen:
		for obj in objectList:
			if obj[1]:
				obj[0].position += Vector2(0,200)
				obj[1] = false
	else:
		for obj in objectList:
			if not obj[1]:
				obj[0].position -= Vector2(0,200)
				obj[1] = true
