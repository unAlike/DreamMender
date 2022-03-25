extends StaticBody2D

export(NodePath) var Player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	var current_line = parse_json(save_game.get_line())
	var character = load(current_line["filename"]).instance()
	get_node(current_line["parent"]).add_child(character)
	Player = character

func _process(delta):
	for c in get_tree().get_nodes_in_group("collider"):
		c.get_child(0).polygon = c.polygon
	
