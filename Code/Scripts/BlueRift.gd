extends "res://Scripts/Rift.gd"

var player : Node2D
var blueRiftLine : Position2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().current_scene.get_node("Player")
	blueRiftLine = get_parent().get_node("BlueRiftFlip")
	

func Interact():
	
	if !player.flipped:
		player.flipped = true
		player.scale.y *= -1
		player.global_position.y = blueRiftLine.global_position.y + abs(player.global_position.y-blueRiftLine.global_position.y)
		player.gravity *= -1
	else: 
		player.flipped = false
		player.global_position.y = blueRiftLine.global_position.y - abs(player.global_position.y-blueRiftLine.global_position.y)
		player.scale.y *= -1
		player.gravity *= -1


func _on_BlueRift_body_entered(body):
	Interact()
	pass # Replace with function body.
