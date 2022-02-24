extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerS
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	playerS = preload("res://Player.tscn")
	player = playerS.instance()
	add_child(player)
	$CollisionShape2D/Polygon2D.polygon = $CollisionShape2D.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
