extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 750
var gravity = 2000
var jumpPower = 1500
var vel = Vector2.ZERO
var numWallJump = 2
var maxNumWallJump = 1
var timeOnWall = 0
var lastDir = 'left'
var threadPath = []
var numDJump = 2
var maxNumDJump = 2
var dir = 0
var state_machine
var lastGround
# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
func get_Input():
	dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += speed
		lastDir = 'right'
		$Sprite.flip_h = false
	if Input.is_action_pressed("walk_left"):
		lastDir = 'left'
		dir -= speed
		$Sprite.flip_h = true
	if Input.is_action_just_pressed("swap"):
		for obj in get_tree().get_nodes_in_group("BlueRift"):
			if obj.riftOpen:
				obj.riftOpen = false
			else:
				obj.riftOpen = true
		for obj in get_tree().get_nodes_in_group("YellowRift"):
			if obj.riftOpen:
				obj.riftOpen = false
			else:
				obj.riftOpen = true
	if Input.is_action_pressed("crouch"):
		#$Sprite.scale.y = lerp($Sprite.scale.y, 1, 1)
		$CollisionPolygon2D.scale.y = lerp($CollisionPolygon2D.scale.y, .5, .5)
		$CollisionPolygon2D.position.y = 30
		dir *= .5
#	else:
		#$Sprite.scale.y = lerp($Sprite.scale.y, 1, 1)
#		$CollisionPolygon2D.scale.y = lerp($CollisionPolygon2D.scale.y, 1, 1)dd
#		$CollisionPolygon2D.position.y = 0
	if dir!=0:
		vel.x = lerp(vel.x, dir, 0.25)
	else:
		vel.x = lerp(vel.x, 0, .1)
		
	if Input.is_action_just_released("zoomin"):
		$Camera2D.zoom = $Camera2D.zoom - Vector2(.1,.1)
		print("IN")
	if Input.is_action_just_released("zoomout"):
		$Camera2D.zoom = $Camera2D.zoom+Vector2(.1,.1)
		
		

func _physics_process(delta):
	if dir!=0 and GroundCheck():
		state_machine.travel("run")
	if dir == 0 and GroundCheck():
		state_machine.travel("idle")
	get_Input()
	vel.y += gravity * delta
		

	if is_on_wall() and numWallJump>0:
		timeOnWall += delta
		if timeOnWall<1 and timeOnWall>.01:
			vel.y = 0
		elif timeOnWall>2 :
			vel.y *= 1
		else:
			vel.y *= .5
	else:
		timeOnWall = 0
	if Input.is_action_just_pressed("jump"):
		if GroundCheck():
			state_machine.travel("jump")
			vel.y = -jumpPower
			numWallJump = maxNumWallJump
			numDJump = maxNumDJump
		if is_on_wall() and numWallJump>0:
			
			vel.y = -jumpPower
			if lastDir == 'left':
				vel.x = jumpPower
			if lastDir == 'right':
				vel.x = -jumpPower
			numWallJump -= 1
		elif numDJump > 0:
			print("DJ")
			$Sprite.frame = 0
			$Sprite.playing = true
			vel.y = -jumpPower
			numDJump -= 1
	if GroundCheck() and dir == 0:
		vel.x = 0
		vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP, true)
	else:
		vel = move_and_slide_with_snap(vel, Vector2.DOWN, Vector2.UP)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if threadPath.size() < 30:
#		threadPath.append($ThreadPos.global_position)
#	else:
#		threadPath.append($ThreadPos.global_position)
#		threadPath.pop_front()
#	update()
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
	var raycasters = [$RayCast2D,$RayCast2D2,$RayCast2D3,$RayCast2D4,$RayCast2D5]
	for c in raycasters:
		if c.is_colliding():
			lastGround = c.get_collision_normal()
			return true
	return false
	
func GetGroundTouching():
	
	return null
