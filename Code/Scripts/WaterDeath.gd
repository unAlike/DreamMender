extends Area2D

onready var Boat = get_tree().current_scene.get_node("Boat")
var boat_scene = preload("res://Scenes/Objects/Boat(New).tscn")
var new_boat = boat_scene.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Player_hit():
	Boat.queue_free()
	add_child(new_boat)
