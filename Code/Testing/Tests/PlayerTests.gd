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

# Developers may create a Scene Director from the string path of the Scene..
# ..and then call .double() on it to create a Scene Test Double, this will
# ..double every node in the Scene as well. Developers may only call double
# ..once, any successive calls will fail.
func test_create_a_test_scene_director_from_string_path() -> void:
	describe("Player is player type")
	var scene = direct.scene("res://Scenes/Player.tscn")
	var double = scene.double()
	asserts.is_class_instance(double, Player)

func test_player_basic_jump() -> void:
	describe("Basic Jump Test")
	var scene = direct.scene("res://Scenes/Player.tscn")
	var player = scene.double()

	player.Jump()
	
	asserts.is_less_than(player.vel.y, 0)
	asserts.is_equal(player.numDJump, 2)
	asserts.is_equal(player.numWallJump, 2)

func test_player_wall_jump() -> void:
	describe("Basic Wall Jump Test")
	var scene = direct.scene("res://Scenes/Player.tscn")
	var player = scene.double()
	asserts.is_equal(player.numDJump, 2)
	asserts.is_equal(player.numWallJump, 2)
	
	player.Wall_Jump()
	asserts.is_equal(player.vel.y, -player.jumpPower * player.scale.y)
	asserts.is_equal(player.numDJump, 2)
	asserts.is_equal(player.numWallJump, 1)

func test_player_double_jump() -> void:
	describe("Basic Double Jump Test")
	var scene = direct.scene("res://Scenes/Player.tscn")
	var player = scene.double()
	player.Double_Jump()
	#asserts.is_equal(player.vel.y, -player.jumpPower * player.scale.y)
	asserts.is_equal(player.numDJump, 1)
	asserts.is_equal(player.numWallJump, 2)

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
