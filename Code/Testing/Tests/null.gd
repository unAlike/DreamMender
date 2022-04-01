extends WAT.Test

# All Tests in WAT must derive from WAT.Test and be stored in the user-defined..
# ..Test Directory. It extends from Godot's Node Class and is added to the..
# ..SceneTree when being executed (therefore if Developers require any of..
# ..their Units under test to be in the SceneTree, they can add those Units..
# ..as children to the current Test Node).

# Developers may override the base title() function to return a string..
# ..which will then be used as the name of the Test in the results view.
func title() -> String:
	return "Null Value Test"
	
# Any method in a Test that starts with the word test is a Test method.
func test_simple_example() -> void:
	describe("My Example Test Method")
	asserts.is_true(true, "optional context")
	
func test_null() -> void:
	# Developers can use the parameters function to run a parameterized tests.
	# parameters takes a 2D array, the first array is the key name used to..
	# ..access the values, and each array after that is the set of values for..
	# ..that instance of the test
	
	# The values that were passed in can be accessed via their respective keys..
	# ..in the p dictionary of WAT.Test
	parameters([["value"], ["null"]])
	
	asserts.is_not_null(p["value"], "Value is not null")
	
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
