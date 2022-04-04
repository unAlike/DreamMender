extends "res://Scripts/Rift.gd"

var player: Script
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().current_scene.get_node("Player").Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if riftOpen:
		$Rift/Particles2D.emitting = true
		for obj in objectList:
			pass
		if lastPlayed == 0:
			$RiftOpen.playing = true
			$RiftClose.playing = false
			lastPlayed = 1
	else:
		$Rift/Particles2D.emitting = false
		for obj in objectList:
			pass
		if lastPlayed == 1:
			$RiftOpen.playing = false
			$RiftClose.playing = true
			lastPlayed = 0
