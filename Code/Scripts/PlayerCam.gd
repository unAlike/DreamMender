extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var relSize = OS.get_screen_size()/get_viewport().get_size()
	var vp = get_viewport()
	print(offset_h)
	if not get_parent().inBlueRift:
		offset_h = clamp( ((((vp.get_mouse_position().x-vp.size.x/4)/vp.size.x) *4* OS.get_screen_size().x) / OS.get_screen_size().x),-1,1)
		offset_v = clamp( ((((vp.get_mouse_position().y-vp.size.y/4)/vp.size.y) *4* OS.get_screen_size().y) / OS.get_screen_size().y),-1,1)
