extends Area2D

var checkpoint_on = preload("res://Art/Misc/DW_Checkpoint_On.png")
onready var checkpoint_sprite = get_node("Sprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Checkpoint_body_entered(body):
	checkpoint_sprite.set_texture(checkpoint_on)
	Checkpoint.last_position = global_position
