extends CanvasLayer

export var Radius = 200
export(PoolStringArray) var Text
export(PoolStringArray) var Text2
export(PoolStringArray) var Text3
var InRadius = false
var Interacting = false
var Interactable = true
var Tracker = 0
var At = 0
var Moving = false
var Cutscene = false


onready var Box = get_node("Background")
onready var Dialogue = get_node("Background/RichTextLabel")
onready var Duration = get_node("Timer")
onready var Bubble = get_node("ENTER")
onready var Player = get_tree().get_current_scene().get_node("Player")
onready var NPC = get_parent().get_node("NPC")
onready var Spools = get_tree().get_current_scene().get_node("Player/Projectile")
onready var Prog = get_tree().get_current_scene().get_node("Player/Progress/Control")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Interactable:
		if Player.get_global_position().distance_to(NPC.get_global_position()) < Radius:
			#print("In Radius")
			InRadius = true
		else:
			InRadius = false
		
		if InRadius and !Interacting:
			Bubble.visible = true
		else:
			Bubble.visible = false
		
		if Cutscene and InRadius:
			Cutscene = false
			Message()
			At += 1
		
		if Input.is_action_just_pressed("ui_accept") and InRadius:
			if !Interacting:
				Interacting = true
				Message()
				At += 1
			elif Interacting and At == Text.size():
				Box.visible = false
				Interacting = false
				At = 0
			elif Interacting and At != Text.size():
				Message()
				At += 1
		
		# To be deleted when movement is disabled
		if Input.is_action_just_pressed("ui_accept") and !InRadius and Interacting:
			Box.visible = false
			Interacting = false
	
	elif Input.is_action_just_pressed("ui_accept") and !Interactable:
		Box.visible = false
		Interacting = false
	
	# Pause player movement while interacting
	if InRadius and Interacting and !Moving:
		Player.set_physics_process(false)
		Spools.set_process(false)
	elif InRadius and !Interacting:
		Player.set_physics_process(true)
		Spools.set_process(true)

func Message():
	pass

func _on_Timer_timeout():
	if Dialogue.visible_characters < Dialogue.text.length():
		Dialogue.visible_characters += 1
	else:
		Duration.stop()
