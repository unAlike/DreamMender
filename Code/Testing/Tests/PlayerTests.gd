extends WAT.Test

# All Tests in WAT must derive from WAT.Test and be stored in the user-defined..
# ..Test Directory. It extends from Godot's Node Class and is added to the..
# ..SceneTree when being executed (therefore if Developers require any of..
# ..their Units under test to be in the SceneTree, they can add those Units..
# ..as children to the current Test Node).

# Developers may override the base title() function to return a string..
# ..which will then be used as the name of the Test in the results view.
func title() -> String:
	return "Player Tests"

# Any method in a Test that starts with the word test is a Test method.
func test_simple_example() -> void:
	describe("My Example Test Method")
	asserts.is_true(true, "optional context")

func test_player_dies_to_spikes() -> void:
	describe("Player should die when _on_SpikeHitbox_body_entered(body)" +
	" is called. Like when the player hits spikes.")
	
	var player = load("res://Scenes//Player.tscn")
	var instance = player.instance()
	
	asserts.is_equal(instance.speed, 500)
	#watch(instance, "hit")
	#instance.die()
	#asserts.signal_was_emitted(instance, "hit")
	#unwatch(instance, "hit")

func start() -> void:
	print("Developers may override the start method to execute code" +
	"before any test method is run in the Test.")
	
func pre() -> void:
	print("Developers may override the pre method to execute code" +
	"before each test method is run in the Test.")
	
func post() -> void:
	print("Developers may override the post method to execute code" +
	"after each test method is run in the Test.")
	
func end() -> void:
	print("Developers may override the end method to execute code" +
	"after all test methods have been run in the Test.")
