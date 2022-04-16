extends "res://Scripts/Rift.gd"

export var fromRotation = 0
export var toRotation = 120
export var backTime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for obj in get_children():
		if obj.get_node("toPos") != null:
			objectList.append([obj,atan2(obj.position.y,obj.position.x)])

 #Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftUnstable:
		if riftActive:
			$Rift/InnerHex.animation = "Open"
			if unstableTimer.time_left>.1:
				for obj in objectList:
					var d = obj[0].position.length()
					var angle = obj[1]
					var lerpVal = lerp(fromRotation,toRotation,unstableTimer.time_left/unstableTimer.wait_time) - rad2deg(angle)
					obj[0].position = (Vector2(d*sin(deg2rad(lerpVal)),d*cos(deg2rad(lerpVal))))
				$Rift.rotation_degrees = lerp(toRotation,fromRotation,unstableTimer.time_left/unstableTimer.wait_time)
		else:
			if unstableTimer.time_left>.1:
				for obj in objectList:
					var d = obj[0].position.length()
					var angle = obj[1]
					var lerpVal = lerp(toRotation,fromRotation,unstableTimer.time_left/unstableTimer.wait_time) - rad2deg(angle)
					obj[0].position = (Vector2(d*sin(deg2rad(lerpVal)),d*cos(deg2rad(lerpVal))))
				$Rift.rotation_degrees = lerp(fromRotation,toRotation,unstableTimer.time_left/unstableTimer.wait_time)
	else:
		if riftActive:
			$Rift/InnerHex.animation = "Open"
			if unstableTimer.time_left>.1:
				for obj in objectList:
					var d = obj[0].position.length()
					var angle = obj[1]
					var lerpVal = lerp(fromRotation,toRotation,riftTimer.time_left/riftTimer.wait_time) - rad2deg(angle)
					obj[0].position = (Vector2(d*sin(deg2rad(lerpVal)),d*cos(deg2rad(lerpVal))))
				$Rift.rotation_degrees = lerp(toRotation,fromRotation,riftTimer.time_left/riftTimer.wait_time)
		else:
			if(riftTimer.time_left>.1):
				for obj in objectList:
					var d = obj[0].position.length()
					var angle = obj[1]
					print(d)
					var lerpVal = lerp(toRotation,fromRotation,riftTimer.time_left/riftTimer.wait_time) - rad2deg(angle)
					obj[0].position = (Vector2(d*sin(deg2rad(lerpVal)),d*cos(deg2rad(lerpVal))))
				$Rift.rotation_degrees = lerp(fromRotation,toRotation,riftTimer.time_left/riftTimer.wait_time)
func _on_Rift_body_entered(body):
	if body.name == "Needle":
		body.queue_free()
		if Spools.redSpool:
			Interact()
