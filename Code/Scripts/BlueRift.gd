extends "res://Scripts/Rift.gd"

var player : KinematicBody2D
var blueRiftLine : Position2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().current_scene.get_node("Player")
	blueRiftLine = get_parent().get_node("BlueRiftFlip")

func _process(delta):
	if not riftTimer.time_left > 0:
		riftActive = true
	if player.inBlueRift:
		player.get_node("Camera2D").zoom = Vector2(3,3)
		player.get_node("Camera2D").global_position.y = get_tree().current_scene.get_node("BlueRiftGroup").get_node("CameraPos").global_position.y
	if riftActive:
		$Rift/Sprite.animation = "Open"
		$Rift/Particles2D.emitting = true
	else:
		$Rift/Sprite.animation = "Closed"
		$Rift/Particles2D.emitting = false

func Interact():
	player.inBlueRift = true
	player.get_node("Camera2D").drag_margin_left = 0
	player.get_node("Camera2D").drag_margin_right = 0
	player.get_node("Camera2D").drag_margin_top = 0
	player.get_node("Camera2D").drag_margin_bottom = 0
	riftTimer.start()
	if riftActive:
		$OpenRift.play()
		riftActive = !riftActive
		if !player.flipped:
			player.flipPlayer()
			player.global_position.y = blueRiftLine.global_position.y + abs(player.global_position.y-blueRiftLine.global_position.y)
			get_parent().get_parent().get_node("MirrorBottom").visible = false
			get_parent().get_parent().get_node("MirrorTop").visible = true
			get_parent().get_parent().get_node("MirrorTop").material.set_shader_param("scale", Vector2(1,-15.5))
		else: 
			player.flipPlayer()
			player.global_position.y = blueRiftLine.global_position.y - abs(player.global_position.y-blueRiftLine.global_position.y)
			get_parent().get_parent().get_node("MirrorBottom").visible = true
			get_parent().get_parent().get_node("MirrorTop").visible = false
			get_parent().get_parent().get_node("MirrorBottom").material.set_shader_param("scale", Vector2(1,15.5))

func _on_Rift_body_entered(body):
	if body.name == "Needle":
		body.queue_free()
		if Stats.getBlue():
			Interact()
