tool
extends Node2D

export var editorProcess: = true setget set_editor_process

export var lineColor: = Color(0.228943, 0.710254, 0.945312)
export var lineWidth: = 10.0
export var triangleColor: = Color(0.722656, 0.908997, 1)

var activePointIndex: = 0

func _ready() -> void:
	if not Engine.editor_hint:
		set_process(false)

func _process(delta: float) -> void:
	update()

# Draws the path of the waypoints for debugging purposes
func _draw() -> void:
	if not Engine.editor_hint:
		return
	if not get_child_count() > 1:
		return
	var points: = PoolVector2Array()
	var triangles: = []
	var last_point: = Vector2.ZERO
	for child in get_children():
		points.append(child.position)
		if points.size() > 1:
			var center: Vector2 = (child.position + last_point) / 2
			var angle: = last_point.angle_to_point(child.position)
			triangles.append({center=center, angle=angle})
		last_point = child.position
	points.append(get_child(0).position)
	
	draw_polyline(points, lineColor, lineWidth, true)
	for triangle in triangles:
		draw_triangle(triangle['center'], triangle['angle'], lineWidth * 2.0)

func get_start_position() -> Vector2:
	return get_child(0).global_position

func get_current_point_position() -> Vector2:
	return get_child(activePointIndex).global_position

func get_next_point_position():
	activePointIndex = (activePointIndex + 1) % get_child_count()
	return get_current_point_position()

func draw_triangle(center:Vector2, angle:float, radius:float) -> void:
	var points: = PoolVector2Array()
	var colors: = PoolColorArray([triangleColor])
	for i in range(3):
		var angle_point: = angle + i * 2.0 * PI / 3.0 + PI
		var offset: = Vector2(radius * cos(angle_point), radius * sin(angle_point))
		var point: = center + offset
		points.append(point)
	draw_polygon(points, colors)

func set_editor_process(value:bool) -> void:
	editorProcess = value
	if not Engine.editor_hint:
		return
	set_process(value)
