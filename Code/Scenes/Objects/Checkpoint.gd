extends Area2D

var activated = false
var checkpoint_on = preload("res://Art/Misc/DW_Checkpoint_On.png")
onready var checkpoint_sprite = get_node("Sprite")
var spinTime = 0
var bobTime = 0
export var spinSpeed = 0.5
export var bobDistance = 5
export var bobSpeed = 1

func _process(delta):
	spinTime += delta*spinSpeed
	$Sprite.rotation = sin(spinTime)/5
	bobTime += delta*bobSpeed
	$Sprite.position.y = sin(bobTime)*bobDistance
	$Sprite.position.y = $Sprite.position.y

func _on_Checkpoint_body_entered(body):
	if body.name == "Player":
		if not activated:
			checkpoint_sprite.set_texture(checkpoint_on)
			Checkpoint.last_position = global_position
			$Hit.play()
			activated = true
			$CPUParticles2D.emitting = false
		
