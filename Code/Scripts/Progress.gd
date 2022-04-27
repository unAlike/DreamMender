extends Control

export var Wait = 3
export var FadeSpeed = .05

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(Wait)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if $Timer.get_time_left() == 0:
		$Button.modulate.a = lerp($Button.modulate.a, 0, FadeSpeed)
		$Count.modulate.a = lerp($Count.modulate.a, 0, FadeSpeed)

func Collected():
	$Button.modulate.a = 1
	$Count.modulate.a = 1
	$Timer.start()

func Yellow():
	$None.visible = false
	$Y.visible = true

func Red():
	$Y.visible = false
	$YR.visible = true

func Blue():
	$YR.visible = false
	$YRB.visible = true
