extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 500
var gravity = 1000
var jumpPower = 700
var vel = Vector2.ZERO
var numWallJump = 2
var maxNumWallJump = 2
var timeOnWall = 0
var lastDir = 'left'
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func get_Input():
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += speed
		lastDir = 'right'
	if Input.is_action_pressed("walk_left"):
		lastDir = 'left'
		dir -= speed
	if Input.is_action_just_pressed("swap"):
		for obj in get_tree().get_nodes_in_group("BlueRift"):
				if obj.riftOpen:
					obj.riftOpen = false
				else:
					obj.riftOpen = true
	if Input.is_action_pressed("crouch"):
		$Sprite.scale.y = lerp($Sprite.scale.y, 65, .5)
		$CollisionPolygon2D.scale.y = lerp($CollisionPolygon2D.scale.y, .5, .5)
		$CollisionPolygon2D.position.y = 30
		dir *= .5
	else:
		$Sprite.scale.y = lerp($Sprite.scale.y, 130, .5)
		$CollisionPolygon2D.scale.y = lerp($CollisionPolygon2D.scale.y, 1, .5)
		$CollisionPolygon2D.position.y = 0
	if dir!=0:
		vel.x = lerp(vel.x, dir, 0.25)
	else:
		vel.x = lerp(vel.x, 0, .1)

func _physics_process(delta):
	get_Input()
	vel.y += gravity * delta
	
	
	if is_on_wall() and numWallJump>0:
		print(timeOnWall)
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
		if is_on_floor():
			vel.y = -jumpPower
			numWallJump = maxNumWallJump
		if is_on_wall() and numWallJump>0:
			vel.y = -jumpPower
			if lastDir == 'left':
				vel.x = jumpPower
			if lastDir == 'right':
				vel.x = -jumpPower
			numWallJump -= 1
	vel = move_and_slide(vel, Vector2.UP)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
