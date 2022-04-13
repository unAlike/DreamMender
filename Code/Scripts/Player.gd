extends KinematicBody2D

signal hit

var speed = 500
var gravity = 2000
var jumpPower = 1000
var vel = Vector2.ZERO
var numWallJump = 2
export var maxNumWallJump = 10
var timeOnWall = 0
var lastDir = 'left'
var threadPath = []
var numDJump = 2
export var  maxNumDJump = 20
var dir = 0
var state_machine : AnimationNodeStateMachinePlayback
var lastGround
var flipped = false
var inBlueRift = false
var lastState = null
var stateConditions
var timeFalling = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	stateConditions = $AnimationTree.get("parameters/conditions")
	$Reflection.scale = $Sprite.scale

func get_Input():
	dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += speed
		lastDir = 'right'
		if is_on_wall() or GroundCheck():
			$Sprite.flip_h = false
	if Input.is_action_pressed("walk_left"):
		lastDir = 'left'
		dir -= speed
		if is_on_wall() or GroundCheck():
			$Sprite.flip_h = true
	if dir!=0:
		vel.x = lerp(vel.x, dir, 0.25)
	else:
		vel.x = lerp(vel.x, 0, .1)
	if Input.is_action_just_released("zoomin") and $Camera2D.zoom > Vector2(1,1):
		$Camera2D.zoom = $Camera2D.zoom - Vector2(.1,.1)
		print("IN")
	if Input.is_action_just_released("zoomout"):# and $Camera2D.zoom < Vector2(2.4,2.4):
		$Camera2D.zoom = $Camera2D.zoom+Vector2(1,1)

func _physics_process(delta):
	if lastState != state_machine.get_current_node():
		lastState = state_machine.get_current_node()
	if GroundCheck():
		numWallJump = maxNumWallJump
		numDJump = maxNumDJump
		if dir!=0:
			state_machine.travel("run")
		if dir == 0:
			state_machine.travel("idle")
	
	get_Input()
	vel.y += gravity * delta
	if is_on_wall() and numWallJump>0:
		state_machine.travel("wall")
		timeOnWall += delta
		vel.y = timeOnWall*100
#		if vel.y>gravity:
#			vel.y = gravity
	else:
		timeOnWall = 0
	if Input.is_action_just_pressed("jump"):
		if GroundCheck():
			state_machine.travel("jump")
			vel.y = -jumpPower * scale.y
		if is_on_wall() and numWallJump>0:
			state_machine.travel("wallJump")
			vel.y = -jumpPower * scale.y
			if lastDir == 'left':
				vel.x = jumpPower
			if lastDir == 'right':
				vel.x = -jumpPower
			numWallJump -= 1
		elif numDJump > 0:
			$Sprite.frame = 0
			$Sprite.playing = true
			$AnimationPlayer.play()
			vel.y = -jumpPower * scale.y
			numDJump -= 1
	if vel.y>1200:
		vel.y = 1200
	var snap = Vector2.ZERO
	if GroundCheck() and dir == 0:
		snap = -get_floor_normal() * .02
		vel.x = 0
		vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP, true, 1, .78)
	else:
		vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP, false, 4, .78)
		
	if $AnimationTree.get("parameters/conditions/falling"):
		if vel.x>0:
			$Sprite.flip_h = false
		if vel.x<0:
			$Sprite.flip_h = true
	
	if timeFalling>.1:
		$AnimationTree.set("parameters/conditions/onGround", GroundCheck())
		$AnimationTree.set("parameters/conditions/onWall", is_on_wall())
		if not is_on_wall() and not GroundCheck():
			$AnimationTree.set("parameters/conditions/falling", true)
		else:
			$AnimationTree.set("parameters/conditions/falling", false)
	else:
		$AnimationTree.set("parameters/conditions/falling", false)
	if not is_on_wall() and !GroundCheck():
		timeFalling+=delta
	else:
		timeFalling = 0
	if not is_on_wall() and !GroundCheck():
		timeFalling+=delta
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Reflection.global_position.y = 7446 + (7446 - global_position.y)
	$Reflection.animation = $Sprite.animation
	$Reflection.playing = $Sprite.playing
	$Reflection.frames = $Sprite.frames
	$Reflection.frame = $Sprite.frame
	$Reflection.flip_h = $Sprite.flip_h
	pass

func _draw():
	for l in range(0,threadPath.size()-1):
		draw_line(to_local(threadPath[l]), to_local(threadPath[l+1]), Color(255,255,255), 5)
		threadPath[l].y+=1
	pass

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
	}
	return save_dict

#Checks all Player Raycast2D's to check if on ground
func GroundCheck():
	if is_on_floor() or $RayCast2D3.is_colliding():
		return true
	return false
#	var raycasters = []
#	for c in get_children():
#		if c is RayCast2D:
#			raycasters.append(c)
#	for c in raycasters:
#		if c.is_colliding():
#			lastGround = c.get_collision_normal()
#			return true
#	return false

func GetGroundTouching():
	if is_on_floor():
		return get_floor_angle()
	return null

# Kills player
func die():
	print("player killed")
	emit_signal("hit")
	#queue_free()
	get_tree().reload_current_scene()

# Checks for collision with dangerous objects that kill player and calls die() function
func _on_SpikeHitbox_body_entered(body):
	print("Touchs")
	die()

func flipPlayer():
	flipped = !flipped
	gravity *= -1
	scale.y *= -1
