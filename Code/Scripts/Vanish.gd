extends AnimatedSprite

var Fade = false
export var FadeSpeed = .025
export var Radius = 100

onready var Player = get_tree().current_scene.get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Player.get_global_position().distance_to(self.get_global_position()) < Radius:
		Fade = true
	if Fade:
		modulate.a = lerp(modulate.a, 0, FadeSpeed)
