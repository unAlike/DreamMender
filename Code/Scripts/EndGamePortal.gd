extends Area2D

var endGame = preload("res://Scenes/EndGameScreen.tscn")

signal win

export var Wait = 5
export var GrowSpeed = .005
export var GrowSize = 5
var Grow = false

func _ready():
	$Timer.set_wait_time(Wait)

func _process(delta):
	if Grow:
		$Light.scale = lerp($Light.scale, Vector2(GrowSize,GrowSize), GrowSpeed)
		$CPUParticles2D.initial_velocity = 100
		$CPUParticles2D.amount = 1000
		get_tree().current_scene.get_node("Player/Music/Song3").volume_db = lerp(get_tree().current_scene.get_node("Player/Music/Song3").volume_db, -100, GrowSpeed)

func _on_EndGamePortal_body_entered(body):
	if body.name == "Needle":
		body.queue_free()
		$Timer.start()
		Grow = true

func _on_Timer_timeout():
	Checkpoint.last_position = null
	get_tree().current_scene.queue_free()
	get_tree().change_scene_to(endGame)
