tool
extends KinematicBody2D

onready var waitTimer: Timer = $Timer
onready var waypoints:= get_node(waypoints_path)

export var editorProcess:= true setget set_editor_process
export var speed:= 400.0

export var waypoints_path:= NodePath()
var targetPosition:= Vector2()

func _ready() -> void:
	if not waypoints:
		set_physics_process(false)
		return
	position = waypoints.get_start_position()
	targetPosition = waypoints.get_next_point_position()

func _physics_process(delta: float) -> void:
	var direction:= (targetPosition - position).normalized()
	var motion:= direction * speed * delta
	var distanceToTarget:= position.distance_to(targetPosition)
	
	if motion.length() > distanceToTarget:
		position = targetPosition
		targetPosition = waypoints.get_next_point_position()
		set_physics_process(false)
		waitTimer.start()
	else:
		position += motion

#Use for debugging to draw shape of rectange that matches collision shape
#func _draw() -> void:
#	var shape: = $CollisionShape2D
#	var extents: Vector2 = shape.shape.extents * 2.0d
#	var rect: = Rect2(shape.position - extents / 2.0, extents)
#	draw_rect(rect, Color('fff'))

func set_editor_process(value:bool) -> void:
	editorProcess = value
	if not Engine.editor_hint:
		return
	set_physics_process(value)

func _on_Timer_timeout() -> void:
	set_physics_process(true)
