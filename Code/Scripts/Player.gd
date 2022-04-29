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
var blueFlipY
var rng : RandomNumberGenerator
onready var pickupCountObject := $Progress/Control/Count
var pickupCount = 0
var musicFade = -1
export var collectableCount = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	stateConditions = $AnimationTree.get("parameters/conditions")
	$AnimationTree.set("parameters/conditions/throwing", false)
	$Reflection.scale = $Sprite.scale
	blueFlipY = get_tree().current_scene.get_node("BlueRiftGroup").get_node("Rifts").get_node("BlueRiftFlip").global_position.y
	rng = RandomNumberGenerator.new()

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
	if Input.is_action_just_released("zoomout") and $Camera2D.zoom < Vector2(2.4,2.4):
		$Camera2D.zoom = $Camera2D.zoom+Vector2(.1,.1)

# Called when jumping off the ground
func Jump():
	jumpSound()
	state_machine.travel("jump")
	vel.y = -jumpPower * scale.y
	

# Called when jumping off a wall
func Wall_Jump():
	state_machine.travel("wallJump")
	vel.y = -jumpPower * scale.y
	if lastDir == 'left':
		vel.x = jumpPower
	if lastDir == 'right':
		vel.x = -jumpPower
	numWallJump -= 1

# Called when player is already in air
# and wants to jump again
func Double_Jump():
	jumpSound()
	$Sprite.frame = 0
	$Sprite.playing = true
	$AnimationPlayer.play()
	vel.y = -jumpPower * scale.y
	numDJump -= 1

# Updates Player's State in lastState
# If on ground, check's if player is runing or idle
# If on ground, resets Jumps and Wall Jumps
func Update_Last_State():
	if lastState != state_machine.get_current_node():
			lastState = state_machine.get_current_node()
	if GroundCheck():
		numWallJump = maxNumWallJump
		numDJump = maxNumDJump
		if not $AnimationTree.get("parameters/conditions/throwing"):
			if dir!=0:
				state_machine.travel("run")
			if dir == 0:
				state_machine.travel("idle")

# Checks if player is on wall and handles acordingly
func Process_On_Wall(delta):
	if is_on_wall() and numWallJump>0:
		state_machine.travel("wall")
		timeOnWall += delta
		vel.y = timeOnWall*100*(gravity/abs(gravity))
	#if vel.y>gravity:
		#vel.y = gravity
	else:
		timeOnWall = 0

func _physics_process(delta):
	get_Input()
	
	# Updates Player's State in lastState
	# If on ground, check's if player is runing or idle
	# If on ground, resets Jumps and Wall Jumps
	Update_Last_State()
	
	vel.y += gravity * delta
	
	# Checks if player is on wall and handles acordingly
	Process_On_Wall(delta)
	
	# Check for jump input
	# and process input
	if Input.is_action_just_pressed("jump"):
		# Jump if on ground
		if GroundCheck():
			Jump()
		# Jump if on wall
		# and you have wall jumps left
		if is_on_wall() and numWallJump>0:
			Wall_Jump()
		# Jump if already in air
		# and you have double jumps left
		elif numDJump > 0:
			Double_Jump()
			
	if vel.y>1200:
		vel.y = 1200
	var snap = Vector2.ZERO
	if GroundCheck() and dir == 0:
		snap = -get_floor_normal() * .02
		vel.x = 0
		vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP, true, 1, .78)
	else:
		vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP, false, 4, .78)
		
	
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
		$AnimationTree.set("parameters/conditions/falling", true)
	else:
		timeFalling = 0
		$AnimationTree.set("parameters/conditions/falling", false)
		
	if GroundCheck():
		$AnimationTree.set("parameters/conditions/onGround", GroundCheck())
		
		
	if $AnimationTree.get("parameters/conditions/falling"):
		if vel.x>0:
			$Sprite.flip_h = false
		if vel.x<0:
			$Sprite.flip_h = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.y > 5500:
		if not $Music/Song3.playing:
			$Music/Song3.play()
			$Music/Song3.volume_db = -30
		if $Music/Song1.volume_db < -40:
			$Music/Song1.playing = false
		else:
			$Music/Song1.volume_db -= delta*20
		if $Music/Song3.volume_db < 0:
			$Music/Song3.volume_db += delta*20
		
	$Reflection.global_position.y =  blueFlipY + (blueFlipY - global_position.y)
	$Reflection.animation = $Sprite.animation
	$Reflection.playing = $Sprite.playing
	$Reflection.frames = $Sprite.frames
	$Reflection.frame = $Sprite.frame
	$Reflection.flip_h = $Sprite.flip_h
	var relSize = OS.get_screen_size()/get_viewport().get_size()
	var vp = get_viewport()
#	print(relSize)
	if !inBlueRift:
		$Camera2D.offset_h = clamp( ((((vp.get_mouse_position().x-vp.size.x/4)/vp.size.x) *4* OS.get_screen_size().x) / OS.get_screen_size().x),-1,1)
		$Camera2D.offset_v = clamp( ((((vp.get_mouse_position().y-vp.size.y/4)/vp.size.y) *4* OS.get_screen_size().y) / OS.get_screen_size().y),-1,1)
#	print( $Camera2D.offse

func _draw():
	for l in range(0,threadPath.size()-1):
		draw_line(to_local(threadPath[l]), to_local(threadPath[l+1]), Color(255,255,255), 5)
		threadPath[l].y+=1
	pass

#Checks all Player Raycast2D's to check if on ground
func GroundCheck():
	if is_on_floor() or $RayCast2D3.is_colliding():
		return true
	return false

func GetGroundTouching():
	if is_on_floor():
		return get_floor_angle()
	return null

# Kills player
func die():
	get_tree()
	emit_signal("hit")
	if Checkpoint.last_position != null:
		global_position = Checkpoint.last_position
	else:
		get_tree().reload_current_scene()
		
func footStep():
	rng.randomize()
	$Sounds/Footsteps.get_children()[rng.randf_range(0, 4)].play()

func throwSound():
	rng.randomize()
	$Sounds/Throw.get_children()[rng.randf_range(0, 2)].play()
	
func jumpSound():
	rng.randomize()
	$Sounds/Jump.get_children()[rng.randf_range(0, 2)].play()

func throwAnim():
	throwSound()
	if get_global_mouse_position().x > global_position.x:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	if get_global_mouse_position().y > global_position.y:
		$Sprite.animation = "throwdown"
	else:
		$Sprite.animation = "throwforward"
func endThrow():
	$AnimationTree.set("parameters/conditions/throwing", false)

# Checks for collision with spikes that kill player and calls die() function
func _on_SpikeHitbox_body_entered(body):
	if body.name == "Player":
		die()

# Flips player and player's gravity
# Sets flipped to current reflection
func flipPlayer():
	flipped = !flipped
	gravity *= -1
	scale.y *= -1

func _on_Area2D_body_entered(body):
	inBlueRift = true
	$Camera2D.drag_margin_left = 0
	$Camera2D.drag_margin_right = 0
	$Camera2D.drag_margin_bottom = 0
	$Camera2D.drag_margin_top = 0

# When the player collects a button
func _on_Collectable_get_button():
	pickupCount += 1
	pickupCountObject.text = str(pickupCount," / ",collectableCount)
	
