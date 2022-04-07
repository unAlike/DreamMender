extends "res://Scripts/Rift.gd"

var player : KinematicBody2D
var blueRiftLine : Position2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().current_scene.get_node("Player")
	blueRiftLine = get_parent().get_node("BlueRiftFlip")

func _process(delta):
	if player.inBlueRift:
		player.get_node("Camera2D").zoom = Vector2(2,2)
		player.get_node("Camera2D").global_position.y = get_tree().current_scene.get_node("BlueRiftGroup").get_node("CameraPos").global_position.y

func Interact():
	player.inBlueRift = true
	if !player.flipped:
		player.flipped = true
		player.scale.y *= -1
		player.global_position.y = blueRiftLine.global_position.y + abs(player.global_position.y-blueRiftLine.global_position.y)
		player.gravity *= -1
		get_parent().get_node("MirrorBottom").visible = false
		get_parent().get_node("MirrorTop").visible = true
		get_parent().get_node("MirrorBottom").material.set_shader_param("scale", Vector2(300,-18))
	else: 
		player.flipped = false
		player.global_position.y = blueRiftLine.global_position.y - abs(player.global_position.y-blueRiftLine.global_position.y)
		player.scale.y *= -1
		player.gravity *= -1
		get_parent().get_node("MirrorBottom").visible = true
		get_parent().get_node("MirrorTop").visible = false
		get_parent().get_node("MirrorBottom").material.set_shader_param("scale", Vector2(300,18))


func _on_BlueRift_body_entered(body):
	Interact()
	pass # Replace with function body.
