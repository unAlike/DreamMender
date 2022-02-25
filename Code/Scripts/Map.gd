extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D/Polygon2D.polygon = $CollisionShape2D.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
