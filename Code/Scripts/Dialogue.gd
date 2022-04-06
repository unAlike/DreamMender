extends CanvasLayer

onready var Box = get_node("Background")
onready var Dialogue = get_node("Background/RichTextLabel")
onready var Duration = get_node("Timer")
onready var Bubble = get_node("ENTER")
export var Radius = 100
export(PoolStringArray) var Text
var InRadius = false
var Interacting = false
var At = 0
onready var Player = get_parent().get_parent().get_node("Player")
onready var NPC = get_parent().get_node("NPC")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Player.get_global_position().distance_to(NPC.get_global_position()) < Radius:
		#print("In Radius")
		InRadius = true
	else:
		InRadius = false
	
	if InRadius and !Interacting:
		Bubble.visible = true
	else:
		Bubble.visible = false
	
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
	if Input.is_action_just_pressed("ui_accept") and !InRadius and Interacting:
		Box.visible = false
		Interacting = false
		At = 0

func Message():
	pass

func _on_Timer_timeout():
	if Dialogue.visible_characters < Dialogue.text.length():
		Dialogue.visible_characters += 1
	else:
		Duration.stop()
