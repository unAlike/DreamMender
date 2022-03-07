extends StaticBody2D

var load_saved_game = false

func _ready():
	$CollisionShape2D/Polygon2D.polygon = $CollisionShape2D.polygon

func save():
	pass
