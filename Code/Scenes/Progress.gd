extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Yellow():
	$None.visible = false
	$Y.visible = true

func Red():
	$Y.visible = false
	$YR.visible = true

func Blue():
	$YR.visible = false
	$YRB.visible = true
