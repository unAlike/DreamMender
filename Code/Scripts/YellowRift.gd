extends "res://Scripts/Rift.gd"

var lerpVal = 1
var platform
var oldScale = Vector2.ZERO
export var delay = 1.0

# Called when the node enters the scene tree for the first time.
func _init():
	platform = load("res://Scripts/Platform.gd")

func _ready():
	oldScale = $Light2D.scale
	for obj in get_children():
		if obj.get_node("toPos") != null:
			var plat = platform.new(obj,obj.get_node("fromPos").global_position,obj.get_node("toPos").global_position)
			objectList.append(plat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftActive == true:
		$Rift/Sprite.animation = "Open"
		$Rift/Particles2D.emitting = true
		$Light2D.scale = lerp($Light2D.scale, oldScale, lerpVal)
		for obj in objectList:
			obj.object.global_position = lerp(obj.fromPos, obj.toPos, lerpVal)
		if lerpVal < 1:
			lerpVal += delta/(riftTimer.wait_time-delay)
	else:
		$Rift/Sprite.animation = "Closed"
		$Rift/Particles2D.emitting = false
		$Light2D.scale = lerp($Light2D.scale, Vector2.ZERO, lerpVal)
		for obj in objectList:
			obj.object.global_position = lerp( obj.fromPos, obj.toPos, lerpVal)
		if lerpVal > 0:
			lerpVal -= delta/(riftTimer.wait_time-delay)

func _on_Rift_body_entered(body):
	if body.name == "Needle":
		body.queue_free()
		Interact()
