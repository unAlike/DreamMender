extends Control

onready var Box = get_node("Background")
onready var Dialogue = get_node("Background/RichTextLabel")
onready var Duration = get_node("Timer")
onready var Bubble = get_node("ENTER")
var Interacting = false
export var Radius = 100
var InRadius = false
onready var Player = get_parent().get_parent()
#onready var NPC = get_parent().get_parent().get_parent().get_node("NPC")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Player.get_global_position().distance_to(NPC.get_position()) < Radius:
		#print("In Range")
		#InRadius = true
	#else:
		#InRadius = false
	
	if InRadius and !Interacting:
		Bubble.visible = true
	else:
		Bubble.visible = false
	
	if Input.is_action_just_pressed("ui_accept") and InRadius:
		if !Interacting:
			Interacting = true
			Message("Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello")
		else:
			Box.visible = false
			Interacting = false

func Message(Text : String):
	Box.visible = true
	Dialogue.text = Text
	Dialogue.visible_characters = 0
	Duration.start()
	

func _on_Timer_timeout():
	if Dialogue.visible_characters < Dialogue.text.length():
		Dialogue.visible_characters += 1
	else:
		Duration.stop()
