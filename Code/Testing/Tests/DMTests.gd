extends WAT.Test

var YellowRift
var Stable
var NeedleScene
var Needle
#var Unstable

func title() -> String:
	return "Rift Test"

func start() -> void:
	YellowRift = load("res://Rifts/YellowRift.tscn")
	Stable = YellowRift.instance()
	add_child(Stable)
	NeedleScene = load("res://Scenes/Needle.tscn")
	#Unstable = YellowRift.instance()
	#add_child(Unstable)

func test_default() -> void:
	describe("Default riftActive Test")
	asserts.is_true(Stable.riftActive, "optional context")

func test_interact() -> void:
	describe("Rift Interact() Result")
	Stable.Interact()
	print(Stable.riftActive)
	asserts.is_false(Stable.riftActive, "optional context")

func test_timer() -> void:
	describe("Rift Timer Reset")
	Stable.Interact()
	asserts.is_true(Stable.riftTimer.get_time_left() > 0, "optional context")

func test_queue_free() -> void:
	describe("Needle Deletion Test")
	Needle = NeedleScene.instance()
	add_child(Needle)
	asserts.is_null(null, "optional context")
